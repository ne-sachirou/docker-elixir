use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [%{version: "5eb2702a301db7d7b6074e2b120735854dd340fa", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "Clojerl",
      short_name: "clje"
    },
    erlang: %{
      versions: [
        %{version: "21.3.8.14", major_version: "21", base_image: "alpine:3.9"},
        %{version: "22.3", major_version: "22", base_image: "alpine:3.11"},
        %{version: "23.0-rc1", major_version: "23", base_image: "alpine:3.11"}
      ],
      latest_major_version: "22",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.9.4", major_version: "1.9"},
        %{version: "1.10.2", major_version: "1.10"}
      ],
      latest_major_version: "1.10",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
