FROM nesachirou/erlang:<%= erlang.major_version %>

ENV PATH=/root/lfe/bin:$PATH

WORKDIR /root

RUN set -ex \
 && apk add --no-cache -t .build-deps build-base git make \
 && mkdir lfe \
 && (cd lfe \
 && git init \
 && git fetch --depth=1 https://github.com/rvirding/lfe.git <%= lfe.version %> \
 && git checkout <%= lfe.version %> \
 && rm -rf .git \
 && make -j) \
 && apk del --purge .build-deps \
 && rm -rf /var/cache/apk/*

CMD ["lfe"]
