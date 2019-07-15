FROM nesachirou/erlang:21

ENV PATH=/root/elixir-1.9.0/bin:$PATH LANG=C.UTF-8

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps make \
 && wget https://github.com/elixir-lang/elixir/archive/v1.9.0.tar.gz \
 && tar xzf v1.9.0.tar.gz \
 && (cd elixir-* \
 && make compile -j) \
 && mix "do" local.hex --force, local.rebar --force \
 && rm v1.9.0.tar.gz \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["iex"]
