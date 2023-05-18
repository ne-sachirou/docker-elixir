import Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "25.3.2", major_version: "25"},
        %{version: "26.0", major_version: "26"}
      ],
      latest_major_version: "25",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.13.4", major_version: "1.13"},
        %{version: "1.14.4", major_version: "1.14"}
      ],
      latest_major_version: "1.14",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
