Erlang & Elixir Dockerfile
==
Erlang & Elixir Dockerfile, supports 2 major versions

Supported tags and respective `Dockerfile` links
--
### [nesachirou/erlang][Erlang Hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][Erlang Hub]
* `20` [(erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/erl20/Dockerfile)
* `21`, `latest` [(erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/erl21/Dockerfile)

### [nesachirou/elixir][Elixir Hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][Elixir Hub]
* `1.5_erl20` [(ex1.5_erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.5_erl20/Dockerfile)
* `1.5_erl21` [(ex1.5_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.5_erl21/Dockerfile)
* `1.6_erl20` [(ex1.6_erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.6_erl20/Dockerfile)
* `1.6_erl21`, `latest` [(ex1.6_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.6_erl21/Dockerfile)

### nesachirou/clojerl
* `HEAD_erl20` [(clje_erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/clje_erl20/Dockerfile)
* `HEAD_erl21` [(clje_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/clje_erl21/Dockerfile)

### nesachirou/lfe
* `HEAD_erl20` [(lfe_erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/lfe_erl20/Dockerfile)
* `HEAD_erl21` [(lfe_erl21/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/lfe_erl21/Dockerfile)

Build images
--
Requirements :
* [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test)
* [Docker](https://www.docker.com/)
* [Digdag](https://www.digdag.io/)
* make
* [Pipenv](https://docs.pipenv.org/)
* Python 3
* [yamllint](https://github.com/adrienverge/yamllint)

```sh
make help
make clean all test
```

TODO:
- [ ] Don't build in Docker. Create Alpine Linux apk packages.
- [ ] Move make + Digdag to [Waf: the meta build system](https://waf.io/)

[Erlang Hub]: https://hub.docker.com/r/nesachirou/erlang/
[Elixir Hub]: https://hub.docker.com/r/nesachirou/elixir/
