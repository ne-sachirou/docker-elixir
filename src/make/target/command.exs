defmodule Make.Target.Command do
  @moduledoc false

  require Logger

  defstruct name: "",
            desc: "",
            status: :none,
            depends: [],
            cmd: nil

  def type, do: :cmd

  defimpl Make.Target do
    def updated_at(_target), do: 0

    def create(target) do
      cmd = target.cmd || target.name
      {_, 0} = System.cmd("sh", ["-eux", "-c", cmd], into: IO.stream(:stdio, :line))
      target
    end
  end
end
