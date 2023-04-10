FROM nesachirou/erlang:25

ENV PATH=/root/elixir-1.14.4/bin:$PATH LANG=C.UTF-8

WORKDIR /root

# hadolint ignore=DL3008
RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    make \
 && curl -fsL https://github.com/elixir-lang/elixir/archive/v1.14.4.tar.gz > v1.14.4.tar.gz \
 && tar xzf v1.14.4.tar.gz \
 && (cd elixir-* \
 && make -j compile) \
 && mix "do" local.hex --force, local.rebar --force \
 && rm v1.14.4.tar.gz \
 && apt-get remove -y \
    curl \
    make \
 && apt-get autoremove -y \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/*

CMD ["iex"]
