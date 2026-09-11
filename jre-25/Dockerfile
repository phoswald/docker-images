FROM alpine:3.24

# Upgrade packages, pulling latest image is not enough!
RUN apk upgrade --no-cache

# For preview packages:
# $ apk add ... --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN apk add --no-cache openjdk25-jre-headless
