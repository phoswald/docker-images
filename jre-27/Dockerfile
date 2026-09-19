FROM alpine:3.24

# Upgrade packages, pulling latest image is not enough!
RUN apk upgrade --no-cache

# For preview packages:
# $ apk add ... --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN apk add --no-cache java-common java-cacerts

ADD jre.tar.gz /usr/lib/jvm/

RUN cd /usr/lib/jvm/ && \
    ln -s *jre27* default-jvm && \
    cd /usr/lib/jvm/default-jvm && \
    ln -s . jre && \
    cd /usr/bin && \
    rm java && \
    ln -s ../lib/jvm/default-jvm/bin/* .
