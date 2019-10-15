# Erlang & Elixir Dockerfile

Erlang & Elixir Dockerfile, supports 2 major versions

## Supported tags and respective `Dockerfile` links

### [nesachirou/erlang][erlang hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][erlang hub]

- `21` [(erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl21/Dockerfile)
- `22`, `latest` [(erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl22/Dockerfile)

### [nesachirou/elixir][elixir hub]

[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][elixir hub]

- `1.8_erl21` [(ex1.8_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.8_erl21/Dockerfile)
- `1.8_erl22` [(ex1.8_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.8_erl22/Dockerfile)
- `1.9_erl21` [(ex1.9_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.9_erl21/Dockerfile)
- `1.9_erl22`, `latest` [(ex1.9_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.9_erl22/Dockerfile)

### nesachirou/clojerl

- `HEAD_erl21` [(clje_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje_erl21/Dockerfile)
- `HEAD_erl22`, `latest` [(clje_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje_erl22/Dockerfile)

### nesachirou/joxa

- `HEAD_erl21` [(jxa_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/jxa_erl21/Dockerfile)
- `HEAD_erl22`, `latest` [(jxa_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/jxa_erl22/Dockerfile)

### nesachirou/lfe

- `HEAD_erl21` [(lfe_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/lfe_erl21/Dockerfile)
- `HEAD_erl22`, `latest` [(lfe_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/lfe_erl22/Dockerfile)

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

[erlang hub]: https://hub.docker.com/r/nesachirou/erlang/
[elixir hub]: https://hub.docker.com/r/nesachirou/elixir/
