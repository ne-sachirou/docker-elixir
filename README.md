# Erlang & Elixir Dockerfile

Erlang & Elixir Dockerfile, supports 2 major versions

## Supported tags and respective `Dockerfile` links

### [nesachirou/erlang][erlang hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][erlang hub]

- `22` [(erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl22/Dockerfile)
- `23`, `latest` [(erl23/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl23/Dockerfile)

### [nesachirou/elixir][elixir hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][elixir hub]

- `1.10_erl22` [(ex1.10_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.10_erl22/Dockerfile)
- `1.10_erl23` [(ex1.10_erl23/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.10_erl23/Dockerfile)
- `1.11_erl22` [(ex1.11_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.11_erl22/Dockerfile)
- `1.11_erl23`, `latest` [(ex1.11_erl23/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.11_erl23/Dockerfile)

### nesachirou/clojerl

- `0.6_erl22` [(clje0.6_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje0.6_erl22/Dockerfile)
- `0.6_erl23`, `latest` [(clje0.6_erl23/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje0.6_erl23/Dockerfile)

## Build images

Requirements :

- [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
- [Docker](https://www.docker.com/)
- [Elixir](https://elixir-lang.org/)
- [jq](https://stedolan.github.io/jq/)
- [yamllint](https://github.com/adrienverge/yamllint)

```sh
git tag -f publish
git push -f origin publish
```

Build at local (for debug) :

```sh
gcloud components install cloud-build-local
cloud-build-local --config priv/cloudbuild.yaml --substitutions='_DOCKER_REGISTRY_PASSWORD=***' .
```

[erlang hub]: https://hub.docker.com/r/nesachirou/erlang/
[elixir hub]: https://hub.docker.com/r/nesachirou/elixir/
