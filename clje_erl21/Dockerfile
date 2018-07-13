FROM nesachirou/erlang:21

ENV PATH=/root/clojerl/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps git make \
 && wget -O /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && mkdir clojerl \
 && (cd clojerl \
 && git init \
 && git remote add origin https://github.com/clojerl/clojerl.git \
 && git fetch origin master \
 && git checkout 69b094b \
 && rm -rf .git \
 && make) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]