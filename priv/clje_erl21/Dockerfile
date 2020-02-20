FROM nesachirou/erlang:21

ENV PATH=/root/clojerl/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps bash git make \
 && wget -O /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && mkdir clojerl \
 && (cd clojerl \
 && git init \
 && git fetch --depth=1 https://github.com/clojerl/clojerl.git 5eb2702a301db7d7b6074e2b120735854dd340fa \
 && git checkout 5eb2702a301db7d7b6074e2b120735854dd340fa \
 && rm -rf .git \
 && make) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]
