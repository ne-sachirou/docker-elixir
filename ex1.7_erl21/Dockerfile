FROM nesachirou/erlang:21

ENV PATH=/root/elixir-1.7.0-rc.1/bin:$PATH LANG=C.UTF-8

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps make \
 && wget https://github.com/elixir-lang/elixir/archive/v1.7.0-rc.1.tar.gz \
 && tar xzvf v1.7.0-rc.1.tar.gz \
 && (cd elixir-* \
 && make compile -j) \
 && mix "do" local.hex --force, local.rebar --force \
 && rm v1.7.0-rc.1.tar.gz \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["iex"]