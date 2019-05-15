defmodule Mix.Tasks.Make do
  @moduledoc """
  Make.

  See `mix make help`.
  """

  @shortdoc "Make. See `mix make help`."

  alias Make.Target

  use Make
  use Mix.Task

  def run(argv) do
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

  defp conf, do: Application.get_env(:make, :langs)

  @spec docker_image_tag(map | binary, map | binary | nil) :: binary
  defp docker_image_tag(%{major_version: erlang_major_version}, target_lang),
    do: docker_image_tag(erlang_major_version, target_lang)

  defp docker_image_tag(erlang, %{major_version: target_lang_major_version}),
    do: docker_image_tag(erlang, target_lang_major_version)

  defp docker_image_tag(erlang_major_version, nil), do: erlang_major_version

  defp docker_image_tag(erlang_major_version, target_lang_major_version),
    do: "#{target_lang_major_version}_erl#{erlang_major_version}"

  @spec targets :: [Target.t()]
  defp targets do
    langs = Map.keys(conf())

    [
      phony("all",
        desc: "Build all Dockerfile & images.",
        depends: [
          {:cmd, "yamllint *.yml .*.yaml .yamllint"},
          cmd("mix format --check-formatted", cwd: ".")
          | Enum.map(langs, &{:phony, to_string(&1)})
        ]
      ),
      cmd("publish",
        desc: "Publish Docker images to DockerHub.",
        depends: [{:phony, "elixir"}, {:phony, "erlang"}],
        cmd:
          for(
            lang <- ~w[erlang elixir]a,
            version <- versions_of(lang) ++ [%{tag: "latest"}],
            into: "",
            do: "docker push nesachirou/#{lang}:#{version.tag}\n"
          )
      )
      | Enum.flat_map(langs, &lang_targets/1)
    ]
  end

  @spec lang_targets(atom) :: [Target.t()]
  defp lang_targets(lang) do
    targets =
      for version <- versions_of(lang),
          erlang = version.erlang,
          target_lang = version[lang],
          dir = version.dir,
          tag = version.tag,
          target <- [
            file("#{dir}/Dockerfile",
              depends: [{:file, "Dockerfile.#{lang}"}],
              how: {EEx, Map.to_list(version)}
            ),
            file("#{dir}/container-structure-test.yml",
              depends: [{:file, "container-structure-test.#{lang}.yml"}],
              how: {EEx, Map.to_list(version)}
            ),
            docker_image("nesachirou/#{lang}:#{tag}",
              depends:
                Enum.reject(
                  [
                    {:file, "#{dir}/Dockerfile"},
                    if(:erlang != lang,
                      do: {:docker_image, "nesachirou/erlang:#{erlang.major_version}"}
                    )
                  ],
                  &is_nil/1
                ),
              context: dir,
              pull?: :erlang == lang
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
                "#{version.natural_name} #{target_lang.major_version}" <>
                  if(:erlang == lang, do: "", else: ", Erlang/TOP #{erlang.major_version}"),
              depends: [{:docker_image, "nesachirou/#{lang}:#{tag}"}, {:cmd, "test #{dir}"}]
            )
          ],
          do: target

    lang_conf = conf()[lang]

    latest_tag =
      Enum.find(versions_of(lang), fn version ->
        version[lang].major_version == lang_conf.latest_major_version and
          if(lang == :erlang,
            do: true,
            else: version.erlang.major_version == conf().erlang.latest_major_version
          )
      end).tag

    [
      cmd("#{lang}:latest",
        depends: [{:phony, "#{lang}:#{latest_tag}"}],
        cmd: "docker tag nesachirou/#{lang}:#{latest_tag} nesachirou/#{lang}:latest"
      ),
      phony(to_string(lang),
        desc: lang_conf.natural_name,
        depends: [
          {:cmd, "#{lang}:latest"}
          | for(version <- versions_of(lang), do: {:phony, "#{lang}:#{version.tag}"})
        ]
      )
      | targets
    ]
  end

  # NOTE: To reject old version,
  #
  # ```
  # defp versions_of(:joxa = lang),
  #   do: lang |> versions_of_p() |> Enum.reject(&(&1.erlang.major_version == "20"))
  # ```
  @spec versions_of(atom) :: [term]
  defp versions_of(lang), do: versions_of_p(lang)

  defp versions_of_p(:erlang = lang) do
    lang_conf = conf()[lang]

    for target_lang <- lang_conf.versions do
      dir = "#{lang_conf.short_name}#{target_lang.major_version}"
      tag = docker_image_tag(target_lang, nil)

      %{dir: dir, tag: tag}
      |> Map.merge(Map.delete(lang_conf, :versions))
      |> Map.merge(%{:lang => lang, lang => target_lang})
    end
  end

  defp versions_of_p(lang) do
    lang_conf = conf()[lang]

    for erlang <- conf().erlang.versions,
        target_lang <- lang_conf.versions do
      dir =
        if "HEAD" == target_lang.major_version,
          do: "#{lang_conf.short_name}_erl#{erlang.major_version}",
          else: "#{lang_conf.short_name}#{target_lang.major_version}_erl#{erlang.major_version}"

      tag = docker_image_tag(erlang, target_lang)

      %{dir: dir, tag: tag}
      |> Map.merge(Map.delete(lang_conf, :versions))
      |> put_in([:erlang], erlang)
      |> Map.merge(%{:lang => lang, lang => target_lang})
    end
  end
end
