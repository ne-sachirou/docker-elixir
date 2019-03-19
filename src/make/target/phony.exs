defmodule Make.Target.Phony do
  @moduledoc false

  defstruct name: "",
            desc: "",
            status: :none,
            depends: []

  def type, do: :phony

  defimpl Make.Target do
    def updated_at(_target), do: 0

    def create(target), do: target
  end
end
