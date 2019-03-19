defprotocol Make.Target do
  @moduledoc false

  def updated_at(target)

  def create(target)
end

for file <- File.ls!(Path.join(__DIR__, "target")),
    String.ends_with?(file, ".exs"),
    do: Code.require_file(file, Path.join(__DIR__, "target"))
