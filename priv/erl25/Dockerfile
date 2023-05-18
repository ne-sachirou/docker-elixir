FROM debian:stable-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /root

# hadolint ignore=DL3003,DL3008
RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    curl \
    libncurses-dev \
    libssl-dev \
    pax-utils \
 && curl -fsL https://github.com/erlang/otp/archive/OTP-25.3.2.tar.gz > OTP-25.3.2.tar.gz \
 && tar xzf OTP-25.3.2.tar.gz \
 && (cd otp-* \
 && ./otp_build autoconf \
 && ./configure \
    --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
    --enable-dynamic-ssl-lib \
    --enable-m64-build \
    --enable-sharing-preserving \
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
 && curl -fsL https://s3.amazonaws.com/rebar3/rebar3 > rebar3 \
 && chmod +x rebar3 \
 && mv rebar3 /usr/local/bin/ \
 && apt-get remove -y \
    autoconf \
    automake \
    build-essential \
    curl \
    pax-utils \
 && apt-get autoremove -y \
 && apt-get autoclean \
 && rm -rf /var/lib/apt/lists/*

CMD ["erl"]
