FROM alpine:3.24

# For preview packages:
# $ apk add ... --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

# Generell
RUN apk add --no-cache curl make tar file

# Für Action Runner: z.B. actions/checkout, actions/cache
RUN apk add --no-cache nodejs

# Für Dockerfiles
RUN apk add --no-cache docker-cli

# Für Java
RUN mkdir -p /usr/local/apache-maven && \
    apk add --no-cache openjdk25-jdk && \
    apk add --no-cache openjdk21-jdk && \
    curl "https://downloads.apache.org/maven/maven-3/3.9.16/binaries/apache-maven-3.9.16-bin.tar.gz" -s | \
    tar -xz -C /usr/local/apache-maven --strip-components=1 && \
    ln -s /usr/local/apache-maven/bin/mvn /usr/local/bin/

# Für C/C++
RUN apk add --no-cache clang

# Für Golang (also adds GCC)
RUN apk add --no-cache go
