FROM nesachirou/erlang:23

ENV PATH=/root/clojerl-0.6.0/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps bash make \
 && wget -O /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && wget https://github.com/clojerl/clojerl/archive/0.6.0.tar.gz \
 && tar xzf 0.6.0.tar.gz \
 && (cd clojerl-* \
 && make -j) \
 && rm 0.6.0.tar.gz \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]
