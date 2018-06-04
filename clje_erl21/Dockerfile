FROM nesachirou/erlang:21

RUN set -ex \
 && apk update \
 && apk add -t .build-deps git make \
 && apk add -t .runtime-deps make \
 && wget -O /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && cd /root \
 && (mkdir clojerl \
 && cd clojerl \
 && git init \
 && git remote add origin https://github.com/clojerl/clojerl.git \
 && git fetch origin master \
 && git checkout e22d0c6 \
 && rm -rf .git \
 && make) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

WORKDIR /root/clojerl

CMD ["make", "repl"]
