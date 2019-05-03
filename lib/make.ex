defmodule Make do
  @moduledoc false

  alias __MODULE__.Session

  @type target_ref :: {atom, binary}

  @type target :: term

  defdelegate create(name, target_ref), to: Session

  defdelegate targets(name), to: Session

  @spec up(Session.name(), [target | target_ref]) :: any
  def up(name, targets) do
    {:ok, _} = Make.Session.start_link(name: name, targets: targets)
    name
  end

  @spec timeout :: pos_integer
  def timeout, do: 1000 * 60 * 60

  @doc false
  @spec target_modules :: [module]
  def target_modules do
    [Make.Target.Command, Make.Target.DockerImage, Make.Target.File, Make.Target.Phony]
  end

  defmacro __using__(_opts) do
    defs =
      for module <- Make.target_modules() do
        quote do
          @spec unquote(module.type())(binary, keyword) :: Make.target()
          def unquote(module.type())(name, opts \\ []),
            do: struct(unquote(module), put_in(opts[:name], name))
        end
      end

    defs
  end
end
