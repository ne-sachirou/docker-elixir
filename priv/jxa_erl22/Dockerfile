FROM nesachirou/erlang:22

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps git make \
 && wget -O /usr/local/bin/rebar https://github.com/rebar/rebar/wiki/rebar \
 && chmod +x /usr/local/bin/rebar \
 && mkdir joxa \
 && (cd joxa \
 && git init \
 && git fetch --depth=1 https://github.com/joxa/joxa.git 8a8594e9c81737be4c81af5a4a8d628211f2f510 \
 && git checkout 8a8594e9c81737be4c81af5a4a8d628211f2f510 \
 && make get-deps \
 && make escript \
 && cp joxa /usr/local/bin/joxa) \
 && rm -rf joxa \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["joxa"]
