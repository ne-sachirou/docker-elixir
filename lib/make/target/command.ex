defmodule Make.Target.Command do
  @moduledoc false

  defstruct name: "",
            desc: "",
            status: :none,
            depends: [],
            cmd: nil,
            cwd: nil

  def type, do: :cmd

  defimpl Make.Target do
    def updated_at(_target), do: 0

    def create(target) do
      cmd = target.cmd || target.name
      cwd = target.cwd || :code.priv_dir(:make)

      {_, 0} =
        System.cmd("sh", ["-eux", "-c", "cd #{cwd} && #{cmd}"], into: IO.stream(:stdio, :line))

      target
    end
  end
end
