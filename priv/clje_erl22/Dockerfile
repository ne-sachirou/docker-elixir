FROM nesachirou/erlang:22

ENV PATH=/root/clojerl/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps bash git make \
 && wget -O /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && mkdir clojerl \
 && (cd clojerl \
 && git init \
 && git fetch --depth=1 https://github.com/clojerl/clojerl.git 2a5852e0b8e5cdcdbf6a151ea25cdcfe4ae755d1 \
 && git checkout 2a5852e0b8e5cdcdbf6a151ea25cdcfe4ae755d1 \
 && rm -rf .git \
 && make) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]
