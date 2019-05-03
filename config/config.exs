use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [%{version: "0b994edabae5ac6882b8a0945489c548c8acda0a", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "Clojerl",
      short_name: "clje"
    },
    erlang: %{
      versions: [
        %{version: "20.3.8.21", major_version: "20"},
        %{version: "21.3.6", major_version: "21"}
      ],
      latest_major_version: "21",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.7.4", major_version: "1.7"},
        %{version: "1.8.1", major_version: "1.8"}
      ],
      latest_major_version: "1.8",
      natural_name: "Elixir",
      short_name: "ex"
    },
    joxa: %{
      versions: [%{version: "8a8594e9c81737be4c81af5a4a8d628211f2f510", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "Joxa",
      short_name: "jxa"
    },
    lfe: %{
      versions: [%{version: "ea62f924b7abbe2a0ff65e27be47acb7f452bc38", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "LFE",
      short_name: "lfe"
    }
  }
