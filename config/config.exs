import Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "24.3.4.8", major_version: "24"},
        %{version: "25.2.1", major_version: "25"}
      ],
      latest_major_version: "25",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.13.4", major_version: "1.13"},
        %{version: "1.14.3", major_version: "1.14"}
      ],
      latest_major_version: "1.14",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
