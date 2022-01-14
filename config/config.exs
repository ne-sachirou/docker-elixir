use Mix.Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "23.3.4.10", major_version: "23"},
        %{version: "24.2", major_version: "24"}
      ],
      latest_major_version: "24",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.12.3", major_version: "1.12"},
        %{version: "1.13.2", major_version: "1.13"}
      ],
      latest_major_version: "1.13",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
