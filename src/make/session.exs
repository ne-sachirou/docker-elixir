defmodule Make.Session do
  @moduledoc false

  alias Make.Target

  require Logger

  use GenServer

  @type name :: atom

  @type status :: :none | :creating | :created | :failed

  @type target_ref :: {atom, binary}

  @type target :: term

  @type t :: %__MODULE__{name: name, targets: %{target_ref => target}}

  defstruct name: nil, targets: %{}

  def start_link(args), do: GenServer.start_link(__MODULE__, args, name: args[:name])

  @impl GenServer
  def init(name: name, targets: targets) do
    targets =
      for target_or_ref <- targets,
          reduce: %{},
          do: (targets -> put_target_or_ref(targets, target_or_ref))

    targets =
      for {{type, name}, target} <- targets, into: %{} do
        target =
          if is_nil(target),
            do: struct(Enum.find(Make.target_modules(), &(&1.type() == type)), name: name),
            else: target

        {{type, name}, target}
      end

    {:ok, %__MODULE__{name: name, targets: targets}}
  end

  @spec create(name, target_ref) :: status
  def create(name, target_ref), do: GenServer.call(name, {:create, target_ref}, Make.timeout())

  @doc false
  @spec put_target(name, target_ref, target) :: any
  def put_target(name, target_ref, target),
    do: GenServer.cast(name, {:put_target, target_ref, target})

  @spec target_status(name, target_ref) :: status
  def target_status(name, target_ref), do: GenServer.call(name, {:target_status, target_ref})

  @spec targets(name) :: %{target_ref => target}
  def targets(name), do: GenServer.call(name, :targets)

  @impl GenServer
  def handle_call({:create, target_ref}, from, session) do
    {target, session} =
      case session.targets[target_ref] do
        nil ->
          raise("Unknown target: #{inspect(target_ref)}")

        target ->
          case target.status do
            :none -> {target, put_in(session.targets[target_ref].status, :creating)}
            status when status in [:creating, :created, :failed] -> {target, session}
          end
      end

    case target.status do
      :none ->
        Logger.info("Start: #{inspect(target_ref)}")

        {:ok, _} =
          Task.start_link(fn ->
            try do
              target.depends
              |> Task.async_stream(&create(session.name, &1), timeout: Make.timeout())
              |> Stream.run()

              target = target |> Target.create() |> put_in([Access.key!(:status)], :created)
              put_target(session.name, target_ref, target)
              GenServer.reply(from, __MODULE__.target_status(session.name, target_ref))
              Logger.info("Created: #{inspect(target_ref)}")
            rescue
              err ->
                Logger.error("Failed: #{inspect(target_ref)}")
                put_target(session.name, target_ref, put_in(target.status, :failed))
                GenServer.reply(from, __MODULE__.target_status(session.name, target_ref))
                reraise err, __STACKTRACE__
            end
          end)

        {:noreply, session}

      :creating ->
        {:ok, _} =
          Task.start_link(fn ->
            100
            |> Stream.interval()
            |> Stream.take_while(fn _ ->
              __MODULE__.target_status(session.name, target_ref) == :creating
            end)
            |> Stream.run()

            GenServer.reply(from, __MODULE__.target_status(session.name, target_ref))
          end)

        {:noreply, session}

      status when status in [:created, :failed] ->
        {:reply, status, session}
    end
  end

  def handle_call({:target_status, target_ref}, _, session),
    do: {:reply, Map.fetch!(session.targets, target_ref).status, session}

  def handle_call(:targets, _, session), do: {:reply, session.targets, session}

  @impl GenServer
  def handle_cast({:put_target, target_ref, target}, session),
    do: {:noreply, put_in(session.targets[target_ref], target)}

  @spec put_target_or_ref(%{target_ref => target | nil}, target | target_ref) :: %{
          target_ref => target | nil
        }
  defp put_target_or_ref(targets, {type, name}),
    do: update_in(targets[{type, name}], &(&1 || nil))

  defp put_target_or_ref(targets, target) do
    targets =
      for target_or_ref <- target.depends,
          reduce: targets,
          do: (targets -> put_target_or_ref(targets, target_or_ref))

    target =
      update_in(
        target,
        [Access.key!(:depends), Access.filter(&is_map/1)],
        &{&1.__struct__.type(), &1.name}
      )

    put_in(targets[{target.__struct__.type(), target.name}], target)
  end
end
