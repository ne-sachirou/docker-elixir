FROM nesachirou/erlang:21

ENV PATH=/root/lfe/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps build-base git make \
 && mkdir lfe \
 && (cd lfe \
 && git init \
 && git remote add origin https://github.com/rvirding/lfe.git \
 && git fetch origin develop \
 && git checkout ea62f92 \
 && rm -rf .git \
 && make -j) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["lfe"]