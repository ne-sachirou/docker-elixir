use Mix.Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "24.3.4.2", major_version: "24"},
        %{version: "25.0.2", major_version: "25"},
      ],
      latest_major_version: "25",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.12.3", major_version: "1.12"},
        %{version: "1.13.4", major_version: "1.13"}
      ],
      latest_major_version: "1.13",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
