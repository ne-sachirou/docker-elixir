use Mix.Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "23.3.4.4", major_version: "23"},
        %{version: "24.0.3", major_version: "24"}
      ],
      latest_major_version: "24",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.11.4", major_version: "1.11"},
        %{version: "1.12.1", major_version: "1.12"}
      ],
      latest_major_version: "1.11",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
