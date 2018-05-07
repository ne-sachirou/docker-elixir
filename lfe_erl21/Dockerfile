FROM nesachirou/erlang:21

ENV PATH=/root/lfe/bin:$PATH

RUN set -ex \
 && apk update \
 && apk add -t .build-deps build-base git make \
 && cd /root \
 && (mkdir lfe \
 && cd lfe \
 && git init \
 && git remote add origin https://github.com/rvirding/lfe.git \
 && git fetch origin develop \
 && git checkout 5faa710 \
 && rm -rf .git \
 && make -j) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["lfe"]
