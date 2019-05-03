defprotocol Make.Target do
  @moduledoc false

  def updated_at(target)

  def create(target)
end
