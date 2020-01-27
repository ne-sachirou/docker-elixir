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
 && git fetch --depth=1 https://github.com/clojerl/clojerl.git 27cacfa9ce58c744db708a7f6d4f25ba703acdc9 \
 && git checkout 27cacfa9ce58c744db708a7f6d4f25ba703acdc9 \
 && rm -rf .git \
 && make) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]
