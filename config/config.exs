use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [%{version: "27cacfa9ce58c744db708a7f6d4f25ba703acdc9", major_version: "HEAD"}],
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
        %{version: "1.9.4", major_version: "1.9"},
        %{version: "1.10.0", major_version: "1.10"}
      ],
      latest_major_version: "1.10",
      natural_name: "Elixir",
      short_name: "ex"
    }
  }
