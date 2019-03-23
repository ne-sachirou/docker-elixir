defmodule Make.Target.DockerImage do
  @moduledoc false

  defstruct name: "",
            desc: "",
            status: :none,
            depends: [],
            context: nil,
            pull?: false

  def type, do: :docker_image

  defimpl Make.Target do
    def updated_at(target) do
      {datetime, 0} =
        System.cmd("sh", ["-c", "docker image inspect #{target.name} | jq -r '.[0].Created'"])

      {:ok, datetime, utc_offset} = datetime |> String.trim() |> DateTime.from_iso8601()
      DateTime.to_unix(datetime) + utc_offset
    end

    def create(target) do
      cmd =
        Enum.join(
          [
            "docker",
            "build",
            "--force-rm",
            if(target.pull?, do: "--pull"),
            "-t",
            target.name,
            target.context || "."
          ],
          " "
        )

      {_, 0} = System.cmd("sh", ["-eux", "-c", cmd], into: IO.stream(:stdio, :line))
      target
    end
  end
end
