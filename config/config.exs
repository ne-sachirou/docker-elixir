import Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "25.3.2.2", major_version: "25"},
        %{version: "26.1", major_version: "26"},
      ],
      latest_major_version: "26",
      natural_name: "Erlang/OTP",
      short_name: "erl",
    },
    elixir: %{
      versions: [
        %{version: "1.14.5", major_version: "1.14"},
        %{version: "1.15.6", major_version: "1.15"},
      ],
      latest_major_version: "1.15",
      natural_name: "Elixir",
      short_name: "ex",
    }
  }
