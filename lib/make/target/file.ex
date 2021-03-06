defmodule Make.Target.File do
  @moduledoc false

  require Logger

  defstruct name: "",
            desc: "",
            status: :none,
            depends: [],
            how: nil

  def type, do: :file

  defimpl Make.Target do
    def updated_at(target) do
      name = Path.join(:code.priv_dir(:make), target.name)

      if File.exists?(name) do
        File.stat!(name).mtime
        |> NaiveDateTime.from_erl!()
        |> DateTime.from_naive!("Etc/UTC")
        |> DateTime.to_unix()
      else
        0
      end
    end

    def create(target) do
      name = Path.join(:code.priv_dir(:make), target.name)
      dirname = Path.dirname(name)

      if File.exists?(dirname) do
        nil
      else
        Logger.info("mkdir -p #{dirname}")
        File.mkdir_p!(dirname)
      end

      case target.how do
        {EEx, bindings} ->
          Logger.info("File creating: #{name}")
          {:file, src} = Enum.find(target.depends, &(elem(&1, 0) == :file))
          src = Path.join(:code.priv_dir(:make), src)
          File.write!(name, EEx.eval_file(src, bindings))

        how when is_function(how) ->
          Logger.info("File creating: #{name}")
          how.(target)

        nil ->
          nil
      end

      unless File.exists?(name), do: raise("Failed to create file: #{target.name}")
      target
    end
  end
end
