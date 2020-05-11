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
        %{version: "21.3.8.15", major_version: "21", base_image: "alpine:3.9"},
        %{version: "22.3.4", major_version: "22", base_image: "alpine:3.11"},
        %{version: "23.0-rc2", major_version: "23", base_image: "alpine:3.11"}
      ],
      latest_major_version: "22",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.9.4", major_version: "1.9"},
        %{version: "1.10.3", major_version: "1.10"}
      ],
      latest_major_version: "1.10",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
