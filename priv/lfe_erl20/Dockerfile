FROM nesachirou/erlang:20

ENV PATH=/root/lfe/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps build-base git make \
 && mkdir lfe \
 && (cd lfe \
 && git init \
 && git fetch --depth=1 https://github.com/rvirding/lfe.git 0775432025f43cafbb7063b5923286bbd700cdf0 \
 && git checkout 0775432025f43cafbb7063b5923286bbd700cdf0 \
 && rm -rf .git \
 && make -j) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["lfe"]
