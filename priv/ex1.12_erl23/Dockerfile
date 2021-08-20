FROM nesachirou/erlang:23

ENV PATH=/root/elixir-1.12.2/bin:$PATH LANG=C.UTF-8

WORKDIR /root

# hadolint ignore=DL3008
RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    make \
 && curl -L https://github.com/elixir-lang/elixir/archive/v1.12.2.tar.gz > v1.12.2.tar.gz \
 && tar xzf v1.12.2.tar.gz \
 && (cd elixir-* \
 && make -j compile) \
 && mix "do" local.hex --force, local.rebar --force \
 && rm v1.12.2.tar.gz \
 && apt-get remove -y \
    curl \
    make \
 && apt-get autoremove -y \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/*

CMD ["iex"]
