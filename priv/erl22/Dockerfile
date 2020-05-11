FROM alpine:3.11

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

WORKDIR /root

# hadolint ignore=DL3017,SC2086
RUN set -ex \
 && apk upgrade && \
    apk add --no-cache -t .build-deps \
    autoconf \
    build-base \
    dpkg \
    dpkg-dev \
    libxml2-utils \
    libxslt \
    lksctp-tools-dev \
    ncurses-dev \
    openjdk8 \
    openssl-dev \
    unixodbc-dev \
    zlib-dev \
 && export PATH=/usr/lib/jvm/java-1.8-openjdk/bin:$PATH \
 && wget https://github.com/erlang/otp/archive/OTP-22.3.4.tar.gz \
 && tar xzf OTP-22.3.4.tar.gz \
 && (cd otp-* \
 && ./otp_build autoconf \
 && ./configure \
    --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    --disable-builtin-zlib \
    --enable-dynamic-ssl-lib \
    --enable-m64-build \
    --enable-sharing-preserving \
    --with-ssl=/usr/include \
    --without-debugger \
    --without-et \
    --without-observer \
    --without-wx \
 && make -j \
 && make -j install) \
 && rm -rf OTP-* otp-* \
 && find /usr/local -regex '/usr/local/lib/erlang/\(lib/\|erts-\).*/\(man\|doc\|obj\|c_src\|emacs\|info\|examples\)' -print0 | xargs -r0 rm -vrf \
 && find /usr/local -type f -regex '.*/src/.*' -not -regex '.*\.hrl$' -exec rm -v {} \+ \
 && find /usr/local -type d -regex '.*/src/.*' -print0 | xargs -r0 -I{} sh -c 'rmdir -pv {} || true' \
 && scanelf -BR -F '%F' -E ET_EXEC /usr/local | xargs -r strip -s \
 && scanelf -BR -F '%F' -E ET_DYN /usr/local | xargs -r strip --strip-unneeded \
 && runDeps="$(scanelf --needed --nobanner --format '%n#p' --recursive /usr/local | tr , '\n' | sort -u | awk 'system("[ -e /usr/local/lib/"$1" ]")==0{next}{print "so:"$1}')" \
 && apk del --purge .build-deps \
 && apk add --no-cache $runDeps lksctp-tools \
 && rm -rf /var/cache/apk/*

CMD ["erl"]
