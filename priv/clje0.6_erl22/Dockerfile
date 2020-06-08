FROM nesachirou/erlang:22

ENV PATH=/root/clojerl-0.6.0/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps bash curl make \
 && curl -L https://s3.amazonaws.com/rebar3/rebar3 > /usr/local/bin/rebar3 \
 && chmod +x /usr/local/bin/rebar3 \
 && curl -L https://github.com/clojerl/clojerl/archive/0.6.0.tar.gz > 0.6.0.tar.gz \
 && tar xzf 0.6.0.tar.gz \
 && (cd clojerl-* \
 && make -j) \
 && rm 0.6.0.tar.gz \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["clojerl"]
