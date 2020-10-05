use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [
        %{version: "0.6.0", major_version: "0.6"}
      ],
      latest_major_version: "0.6",
      natural_name: "Clojerl",
      short_name: "clje"
    },
    erlang: %{
      versions: [
        %{version: "22.3.4.11", major_version: "22", base_image: "alpine:3.12"},
        %{version: "23.1.1", major_version: "23", base_image: "alpine:3.12"}
      ],
      latest_major_version: "23",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.9.4", major_version: "1.9"},
        %{version: "1.10.4", major_version: "1.10"}
      ],
      latest_major_version: "1.10",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
