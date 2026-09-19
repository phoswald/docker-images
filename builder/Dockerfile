FROM alpine:3.24

ARG JDK_ARCHIVE="zulu27.28.101-ca-jdk27.0.0-linux_musl_x64"

ARG MAVEN_VERSION="3.9.16"
ARG MAVEN_ARCHIVE="apache-maven-${MAVEN_VERSION}"

# Upgrade packages, pulling latest image is not enough!
RUN apk upgrade --no-cache

# For preview packages:
# $ apk add ... --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Generell
RUN apk add --no-cache curl make file

# Für Action Runner: z.B. actions/checkout, actions/cache
RUN apk add --no-cache nodejs

# Für Dockerfiles
RUN apk add --no-cache docker-cli

# NOTICE:
# - java-common java-cacerts are required by older openjdk*-jre-headless.
#   They assume /usr/lib/jvm/default-jvm and /usr/bin/java links to that.
# - libx11 libxext libxi libxrender libxtst alsa-lib freetype giflib libjpeg-turbo lcms2 libpng are required by older openjdk*-jre|jdk.
RUN apk add --no-cache java-common java-cacerts && \
    apk add --no-cache libx11 libxext libxi libxrender libxtst alsa-lib freetype giflib libjpeg-turbo lcms2 libpng

# Für Java
RUN apk add --no-cache openjdk25-jdk && \
    apk add --no-cache openjdk21-jdk && \
    mkdir -p /usr/lib/jvm/ && \
    curl "https://cdn.azul.com/zulu/bin/${JDK_ARCHIVE}.tar.gz" -s | \
    tar -xz -C /usr/lib/jvm && \ 
    ln -s "${JDK_ARCHIVE}" /usr/lib/jvm/java-27-openjdk && \
    ln -sfn "${JDK_ARCHIVE}" /usr/lib/jvm/default-jvm && \
    ln -s . "/usr/lib/jvm/${JDK_ARCHIVE}/jre" && \
    ln -sf /usr/lib/jvm/default-jvm/bin/* /usr/bin/ && \
    curl "https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_ARCHIVE}-bin.tar.gz" -s | \
    tar -xz -C /usr/local && \
    ln -s /usr/local/${MAVEN_ARCHIVE}/bin/mvn /usr/local/bin/

# Für C/C++
RUN apk add --no-cache clang

# Für Golang (also adds GCC)
RUN apk add --no-cache go
