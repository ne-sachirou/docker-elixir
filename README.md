Erlang & Elixir Dockerfile
==
Erlang & Elixir Dockerfile, supports 2 major versions

Supported tags and respective `Dockerfile` links
==
[nesachirou/erlang][Erlang Hub]
--
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/erlang.svg)][Erlang Hub]
* `19` [(erl19/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/erl19/Dockerfile)
* `20`, `latest` [(erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/erl20/Dockerfile)

[nesachirou/elixir][Elixir Hub]
--
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/elixir.svg)][Elixir Hub]
* `1.5_erl19` [(ex1.5_erl19/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.5_erl19/Dockerfile)
* `1.5_erl20` [(ex1.5_erl20/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.5_erl20/Dockerfile)
* `1.6_erl19` [(ex1.6_erl19/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.6_erl19/Dockerfile)
* `1.6_erl20`, `latest` [(ex1.6_erl19/Dockerfile)](https://github.com/ne-sachirou/docker-elixir/blob/master/ex1.6_erl20/Dockerfile)

TODO:
- [ ] Don't build in Docker. Create Alpine Linux apk packages.
- [ ] Move make + Digdag to [Waf: the meta build system][Waf]

[Erlang Hub]: https://hub.docker.com/r/nesachirou/erlang/
[Elixir Hub]: https://hub.docker.com/r/nesachirou/elixir/
[Waf]: https://waf.io/
