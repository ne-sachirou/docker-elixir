use Mix.Config

config :make,
  langs: %{
    erlang: %{
      versions: [
        %{version: "22.3.4.16", major_version: "22", base_image: "alpine:3.12"},
        %{version: "23.3", major_version: "23", base_image: "alpine:3.13"},
        %{version: "24.0-rc2", major_version: "24", base_image: "alpine:3.13"}
      ],
      latest_major_version: "23",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.10.4", major_version: "1.10"},
        %{version: "1.11.4", major_version: "1.11"}
      ],
      latest_major_version: "1.11",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
