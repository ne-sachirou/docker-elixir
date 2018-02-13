FROM nesachirou/erlang:19

ENV PATH=/root/elixir/bin:$PATH LANG=C.UTF-8

RUN set -ex \
 && apk update \
 && apk add -t .build-deps unzip \
 && cd /root \
 && wget https://github.com/elixir-lang/elixir/releases/download/v1.5.3/Precompiled.zip \
 && unzip Precompiled.zip -d elixir \
 && mix do local.hex --force, local.rebar --force \
 && rm Precompiled.zip \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["iex"]
