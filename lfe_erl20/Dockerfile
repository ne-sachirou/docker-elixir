FROM nesachirou/erlang:20

ENV PATH=/root/lfe/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps build-base git make \
 && mkdir lfe \
 && (cd lfe \
 && git init \
 && git fetch --depth=1 https://github.com/rvirding/lfe.git ea62f924b7abbe2a0ff65e27be47acb7f452bc38 \
 && git checkout ea62f924b7abbe2a0ff65e27be47acb7f452bc38 \
 && rm -rf .git \
 && make -j) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["lfe"]