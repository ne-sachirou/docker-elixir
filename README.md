[![Coverage Status](https://coveralls.io/repos/github/AUTHOR_NAME/PROJECT_NAME/badge.svg)](https://coveralls.io/github/AUTHOR_NAME/PROJECT_NAME)
[![Actions Status](https://github.com/AUTHER_NAME/PROJECT_NAME/workflows/test/badge.svg)](https://github.com/AUTHER_NAME/PROJECT_NAME/actions)
[![Hex.pm](https://img.shields.io/hexpm/v/PROJECT_NAME.svg)](https://hex.pm/packages/PROJECT_NAME)

# Erlang & Elixir Dockerfile

Erlang & Elixir Dockerfile, supports 2 major versions

## Supported tags and respective `Dockerfile` links

### [nesachirou/erlang][erlang hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][erlang hub]

- `24` [(erl24/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl24/Dockerfile)
- `25`, `latest` [(erl25/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl25/Dockerfile)

### [nesachirou/elixir][elixir hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][elixir hub]

- `1.13_erl24` [(ex1.13_erl24/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.13_erl24/Dockerfile)
- `1.13_erl25`, [(ex1.13_erl25/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.13_erl25/Dockerfile)
- `1.14_erl24` [(ex1.14_erl24/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.14_erl24/Dockerfile)
- `1.14_erl25`, `latest` [(ex1.14_erl25/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.14_erl25/Dockerfile)

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
