use Mix.Config

config :make,
  langs: %{
    clojerl: %{
      versions: [%{version: "0bbcbec65a0f2dfc6391adf0c573b697433bcf6b", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "Clojerl",
      short_name: "clje"
    },
    erlang: %{
      versions: [
        %{version: "21.3.8.1", major_version: "21"},
        %{version: "22.0", major_version: "22"}
      ],
      latest_major_version: "22",
      natural_name: "Erlang/OTP",
      short_name: "erl"
    },
    elixir: %{
      versions: [
        %{version: "1.7.4", major_version: "1.7"},
        %{version: "1.8.2", major_version: "1.8"}
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
      versions: [%{version: "0775432025f43cafbb7063b5923286bbd700cdf0", major_version: "HEAD"}],
      latest_major_version: "HEAD",
      natural_name: "LFE",
      short_name: "lfe"
    }
  }
