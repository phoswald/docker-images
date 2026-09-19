FROM alpine:3.24

ARG JRE_ARCHIVE="zulu27.28.101-ca-jre27.0.0-linux_musl_x64"

# Upgrade packages, pulling latest image is not enough!
RUN apk upgrade --no-cache

# Generell
RUN apk add --no-cache curl

# NOTICE: java-common and java-cacerts are required by older openjdk*-jre-headless.
# They assume /usr/lib/jvm/default-jvm and /usr/bin/java links to that.
RUN apk add --no-cache java-common java-cacerts

# For preview packages:
# $ apk add ... --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN mkdir -p /usr/lib/jvm/ && \
    curl "https://cdn.azul.com/zulu/bin/${JRE_ARCHIVE}.tar.gz" -s | \
    tar -xz -C /usr/lib/jvm && \ 
    ln -sfn "${JRE_ARCHIVE}" /usr/lib/jvm/default-jvm && \
    ln -s . "/usr/lib/jvm/${JRE_ARCHIVE}/jre" && \
    ln -sf /usr/lib/jvm/default-jvm/bin/* /usr/bin/
