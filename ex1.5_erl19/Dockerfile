FROM nesachirou/erlang:19

RUN apk add -U \
    curl \
    unzip \
 && cd /root \
 && curl -L https://github.com/elixir-lang/elixir/releases/download/v1.5.3/Precompiled.zip > Precompiled.zip \
 && unzip Precompiled.zip -d elixir \
 && rm Precompiled.zip \
 && apk del \
    curl \
    unzip \
 && rm -rf /var/cache/apk/*

ENV PATH=/root/elixir/bin:$PATH

RUN mix do local.hex --force, local.rebar --force
