#! /usr/bin/env elixir

for file <- File.ls!(Path.join(__DIR__, "src")),
    String.ends_with?(file, ".exs"),
    do: Code.require_file(file, Path.join(__DIR__, "src"))

defmodule Main do
  @moduledoc false

  use Make

  def main(argv) do
    make_name = :docker_elixir
    Make.up(make_name, targets())

    if [] == argv or "help" in argv do
      make_name
      |> Make.targets()
      |> Map.values()
      |> Enum.reject(&(&1.desc == ""))
      |> Enum.sort_by(& &1.name)
      |> Enum.each(&IO.puts("#{String.pad_trailing(&1.name, 24)}\t#{&1.desc}"))
    else
      target_refs = make_name |> Make.targets() |> Map.keys()

      argv
      |> Task.async_stream(
        fn target_name ->
          Make.create(make_name, Enum.find(target_refs, &(elem(&1, 1) == target_name)))
        end,
        timeout: Make.timeout()
      )
      |> Stream.run()
    end
  end

  def targets do
    Enum.concat([
      clojerl_targets(),
      elixir_targets(),
      erlang_targets(),
      joxa_targets(),
      lfe_targets(),
      [
        phony("all",
          desc: "Build all Dockerfile & images.",
          depends:
            [{:cmd, "yamllint *.yml .*.yaml .yamllint"}, {:cmd, "mix format --check-formatted"}] ++
              (conf() |> Map.keys() |> Enum.map(&{:phony, to_string(&1)}))
        ),
        cmd("publish",
          desc: "Publish Docker images to DockerHub.",
          depends: [{:phony, "elixir"}, {:phony, "erlang"}],
          cmd:
            [
              for(
                erlang <- conf().erlang.versions,
                tag = erlang.major_version,
                do: "docker push nesachirou/erlang:#{tag}"
              ),
              "docker push nesachirou/erlang:latest",
              for(
                elixir <- conf().elixir.versions,
                erlang <- conf().erlang.versions,
                tag = "#{elixir.major_version}_erl#{erlang.major_version}",
                do: "docker push nesachirou/elixir:#{tag}"
              ),
              "docker push nesachirou/elixir:latest"
            ]
            |> List.flatten()
            |> Enum.join("\n")
        )
      ]
    ])
  end

  def clojerl_targets do
    lang = :clojerl
    lang_natural = "Clojerl"
    lang_short = "clje"

    targets =
      for erlang <- conf().erlang.versions,
          clojerl <- conf()[lang].versions,
          dir = "#{lang_short}_erl#{erlang.major_version}",
          tag = "#{clojerl.major_version}_erl#{erlang.major_version}",
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, binding()}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, binding()}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:docker_image, "nesachirou/erlang:#{erlang.major_version}"}
              ],
              context: dir
            ),
            cmd("test #{dir}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:file, "#{dir}/container-structure-test.yml"},
                {:docker_image, "nesachirou/#{lang}:#{tag}"}
              ],
              cmd: """
              hadolint #{dir}/Dockerfile
              container-structure-test test \
                --image nesachirou/#{lang}:#{tag} \
                --config #{dir}/container-structure-test.yml
              """
            ),
            phony("#{lang}:#{tag}",
              desc:
                "#{lang_natural} #{clojerl.major_version}, Erlang/TOP #{erlang.major_version}",
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest}"}],
        cmd:
          "docker tag nesachirou/#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest} nesachirou/#{
            lang
          }:latest"
      ),
      phony(to_string(lang),
        desc: lang_natural,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(
              erlang <- conf().erlang.versions,
              clojerl <- conf()[lang].versions,
              do: {:phony, "#{lang}:#{clojerl.major_version}_erl#{erlang.major_version}"}
            )
        ]
      )
      | targets
    ]
  end

  def elixir_targets do
    lang = :elixir
    lang_natural = "Elixir"
    lang_short = "ex"

    targets =
      for erlang <- conf().erlang.versions,
          elixir <- conf()[lang].versions,
          dir = "#{lang_short}#{elixir.major_version}_erl#{erlang.major_version}",
          tag = "#{elixir.major_version}_erl#{erlang.major_version}",
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, binding()}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, binding()}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:docker_image, "nesachirou/erlang:#{erlang.major_version}"}
              ],
              context: dir
            ),
            cmd("test #{dir}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:file, "#{dir}/container-structure-test.yml"},
                {:docker_image, "nesachirou/#{lang}:#{tag}"}
              ],
              cmd: """
              hadolint #{dir}/Dockerfile
              container-structure-test test \
                --image nesachirou/#{lang}:#{tag} \
                --config #{dir}/container-structure-test.yml
              """
            ),
            phony("#{lang}:#{tag}",
              desc: "#{lang_natural} #{elixir.major_version}, Erlang/OTP #{erlang.major_version}",
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest}"}],
        cmd:
          "docker tag nesachirou/#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest} nesachirou/#{
            lang
          }:latest"
      ),
      phony(to_string(lang),
        desc: lang_natural,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(
              erlang <- conf().erlang.versions,
              elixir <- conf()[lang].versions,
              do: {:phony, "#{lang}:#{elixir.major_version}_erl#{erlang.major_version}"}
            )
        ]
      )
      | targets
    ]
  end

  def erlang_targets do
    lang = :erlang
    lang_natural = "Erlang/OTP"
    lang_short = "erl"

    targets =
      for erlang <- conf()[lang].versions,
          dir = "#{lang_short}#{erlang.major_version}",
          tag = erlang.major_version,
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, binding()}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, binding()}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends: [{:file, "#{dir}/Dockerfile"}],
              context: dir
            ),
            cmd("test #{dir}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:file, "#{dir}/container-structure-test.yml"},
                {:docker_image, "nesachirou/#{lang}:#{tag}"}
              ],
              cmd: """
              hadolint #{dir}/Dockerfile
              container-structure-test test \
                --image nesachirou/#{lang}:#{tag} \
                --config #{dir}/container-structure-test.yml
              """
            ),
            phony("#{lang}:#{tag}",
              desc: "#{lang_natural} #{erlang.major_version}",
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{conf()[lang].latest}"}],
        cmd: "docker tag nesachirou/#{lang}:#{conf()[lang].latest} nesachirou/#{lang}:latest"
      ),
      phony(to_string(lang),
        desc: lang_natural,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(
              erlang <- conf()[lang].versions,
              do: {:phony, "#{lang}:#{erlang.major_version}"}
            )
        ]
      )
      | targets
    ]
  end

  def joxa_targets do
    lang = :joxa
    lang_natural = "Joxa"
    lang_short = "jxa"

    targets =
      for erlang <- conf().erlang.versions,
          joxa <- conf()[lang].versions,
          erlang.major_version != "20",
          dir = "#{lang_short}_erl#{erlang.major_version}",
          tag = "#{joxa.major_version}_erl#{erlang.major_version}",
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, binding()}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, binding()}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:docker_image, "nesachirou/erlang:#{erlang.major_version}"}
              ],
              context: dir
            ),
            cmd("test #{dir}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:file, "#{dir}/container-structure-test.yml"},
                {:docker_image, "nesachirou/#{lang}:#{tag}"}
              ],
              cmd: """
              hadolint #{dir}/Dockerfile
              container-structure-test test \
                --image nesachirou/#{lang}:#{tag} \
                --config #{dir}/container-structure-test.yml
              """
            ),
            phony("#{lang}:#{tag}",
              desc: "#{lang_natural} #{joxa.major_version}, Erlang/TOP #{erlang.major_version}",
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest}"}],
        cmd:
          "docker tag nesachirou/#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest} nesachirou/#{
            lang
          }:latest"
      ),
      phony(to_string(lang),
        desc: lang_natural,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(
              erlang <- conf().erlang.versions,
              joxa <- conf()[lang].versions,
              do: {:phony, "#{lang}:#{joxa.major_version}_erl#{erlang.major_version}"}
            )
        ]
      )
      | targets
    ]
  end

  def lfe_targets do
    lang = :lfe
    lang_natural = "LFE"
    lang_short = "lfe"

    targets =
      for erlang <- conf().erlang.versions,
          lfe <- conf()[lang].versions,
          dir = "#{lang_short}_erl#{erlang.major_version}",
          tag = "#{lfe.major_version}_erl#{erlang.major_version}",
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, binding()}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, binding()}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:docker_image, "nesachirou/erlang:#{erlang.major_version}"}
              ],
              context: dir
            ),
            cmd("test #{dir}",
              depends: [
                {:file, "#{dir}/Dockerfile"},
                {:file, "#{dir}/container-structure-test.yml"},
                {:docker_image, "nesachirou/#{lang}:#{tag}"}
              ],
              cmd: """
              hadolint #{dir}/Dockerfile
              container-structure-test test \
                --image nesachirou/#{lang}:#{tag} \
                --config #{dir}/container-structure-test.yml
              """
            ),
            phony("#{lang}:#{tag}",
              desc: "#{lang_natural} #{lfe.major_version}, Erlang/TOP #{erlang.major_version}",
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest}"}],
        cmd:
          "docker tag nesachirou/#{lang}:#{conf()[lang].latest}_erl#{conf().erlang.latest} nesachirou/#{
            lang
          }:latest"
      ),
      phony(to_string(lang),
        desc: lang_natural,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(
              erlang <- conf().erlang.versions,
              lfe <- conf()[lang].versions,
              do: {:phony, "#{lang}:#{lfe.major_version}_erl#{erlang.major_version}"}
            )
        ]
      )
      | targets
    ]
  end

  def conf do
    %{
      clojerl: %{
        versions: [%{version: "35f0837225e9ea6cd79f8ba556030f953cadc6ce", major_version: "HEAD"}],
        latest: "HEAD"
      },
      erlang: %{
        versions: [
          %{version: "20.3.8.20", major_version: "20"},
          %{version: "21.3.2", major_version: "21"}
        ],
        latest: "21"
      },
      elixir: %{
        versions: [
          %{version: "1.7.4", major_version: "1.7"},
          %{version: "1.8.1", major_version: "1.8"}
        ],
        latest: "1.8"
      },
      joxa: %{
        versions: [%{version: "8a8594e9c81737be4c81af5a4a8d628211f2f510", major_version: "HEAD"}],
        latest: "HEAD"
      },
      lfe: %{
        versions: [%{version: "ea62f924b7abbe2a0ff65e27be47acb7f452bc38", major_version: "HEAD"}],
        latest: "HEAD"
      }
    }
  end
end

Main.main(System.argv())
