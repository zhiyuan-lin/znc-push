FROM znc:slim

COPY ./push.cpp /znc-src/


RUN set -x \
    && apk add --no-cache --virtual build-dependencies \
        build-base \
        cmake \
        icu-dev \
        curl-dev \
    && cd /znc-src \
    && CXXFLAGS="-DPUSHVERSION=\"2.0\" -DUSE_CURL -lcurl" /opt/znc/bin/znc-buildmod push.cpp \
    && mv /znc-src/push.so /opt/znc/lib/znc/ \
    && apk del build-dependencies \
    && cd / && rm -rf /znc-src

VOLUME /znc-data

ENTRYPOINT ["/entrypoint.sh"]
