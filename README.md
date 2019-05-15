Erlang & Elixir Dockerfile
==
Erlang & Elixir Dockerfile, supports 2 major versions

Supported tags and respective `Dockerfile` links
--
### [nesachirou/erlang][Erlang Hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][Erlang Hub]
* `21` [(erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl21/Dockerfile)
* `22`, `latest` [(erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/erl22/Dockerfile)

### [nesachirou/elixir][Elixir Hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][Elixir Hub]
* `1.7_erl21` [(ex1.7_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.7_erl21/Dockerfile)
* `1.7_erl22` [(ex1.7_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.7_erl22/Dockerfile)
* `1.8_erl21` [(ex1.8_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.8_erl21/Dockerfile)
* `1.8_erl22`, `latest` [(ex1.8_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/ex1.8_erl22/Dockerfile)

### nesachirou/clojerl
* `HEAD_erl21` [(clje_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje_erl21/Dockerfile)
* `HEAD_erl22`, `latest` [(clje_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/clje_erl22/Dockerfile)

### nesachirou/joxa
* `HEAD_erl21` [(jxa_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/jxa_erl21/Dockerfile)
* `HEAD_erl22`, `latest` [(jxa_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/jxa_erl22/Dockerfile)

### nesachirou/lfe
* `HEAD_erl21` [(lfe_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/lfe_erl21/Dockerfile)
* `HEAD_erl22`, `latest` [(lfe_erl22/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/priv/lfe_erl22/Dockerfile)

Build images
--
Requirements :
* [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
* [Docker](https://www.docker.com/)
* [Elixir](https://elixir-lang.org/)
* [jq](https://stedolan.github.io/jq/)
* [yamllint](https://github.com/adrienverge/yamllint)

```sh
mix deps.get
mix do compile, make help
mix make all publish
```

[Erlang Hub]: https://hub.docker.com/r/nesachirou/erlang/
[Elixir Hub]: https://hub.docker.com/r/nesachirou/elixir/
