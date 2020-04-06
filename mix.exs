defmodule Make.MixProject do
  use Mix.Project

  def project do
    [
      app: :make,
      deps: deps(),
      dialyzer: [
        remove_defaults: [:unknown]
      ],
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      version: "0.1.0"
    ]
  end

  def application, do: [extra_applications: [:logger]]

  defp deps do
    [
      {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]}
    ]
  end
end
