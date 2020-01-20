use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [%{version: "529b9e38f89b0d4b8e23a8da37f314d4aad9480d", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "Clojerl",
      short_name: "clje"
    },
    erlang: %{
      versions: [
        %{version: "21.3.8.12", major_version: "21", base_image: "alpine:3.9"},
        %{version: "22.2.3", major_version: "22", base_image: "alpine:3.11"}
      ],
      latest_major_version: "22",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.8.2", major_version: "1.8"},
        %{version: "1.9.4", major_version: "1.9"},
        %{version: "1.10.0-rc.0", major_version: "1.10"}
      ],
      latest_major_version: "1.9",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
