DOCKER_TAG=latest

all: build test

build: build-jre-25 build-jre-21 build-builder

build-jre-25:
	docker build -t philip/jre-25:$(DOCKER_TAG) jre-25/

build-jre-21:
	docker build -t philip/jre-21:$(DOCKER_TAG) jre-21/

build-builder:
	docker build -t philip/builder:$(DOCKER_TAG) builder/

test:
	docker run --rm philip/jre-25:$(DOCKER_TAG)  java -version
	docker run --rm philip/jre-21:$(DOCKER_TAG)  java -version
	docker run --rm philip/builder:$(DOCKER_TAG) node --version 
	docker run --rm philip/builder:$(DOCKER_TAG) docker --version
	docker run --rm philip/builder:$(DOCKER_TAG) java -version
	docker run --rm philip/builder:$(DOCKER_TAG) javac -version
	docker run --rm philip/builder:$(DOCKER_TAG) mvn -version
	docker run --rm philip/builder:$(DOCKER_TAG) /usr/lib/jvm/java-21-openjdk/bin/java -version
	docker run --rm philip/builder:$(DOCKER_TAG) /usr/lib/jvm/java-21-openjdk/bin/javac -version
	docker run --rm -e JAVA_HOME=/usr/lib/jvm/java-21-openjdk/ philip/builder:$(DOCKER_TAG) mvn -version
	docker run --rm philip/builder:$(DOCKER_TAG) clang --version
	docker run --rm philip/builder:$(DOCKER_TAG) go version

push:
	docker login $(DOCKER_REGISTRY) -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag philip/jre-25:$(DOCKER_TAG)  $(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25:$(DOCKER_TAG)
	docker tag philip/jre-21:$(DOCKER_TAG)  $(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-21:$(DOCKER_TAG)
	docker tag philip/builder:$(DOCKER_TAG) $(DOCKER_REGISTRY)/$(DOCKER_USER)/builder:$(DOCKER_TAG)
	docker push $(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25:$(DOCKER_TAG)
	docker push $(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-21:$(DOCKER_TAG)
	docker push $(DOCKER_REGISTRY)/$(DOCKER_USER)/builder:$(DOCKER_TAG)
	docker logout $(DOCKER_REGISTRY)

clean:
	docker rmi -f philip/jre-25:$(DOCKER_TAG)  2> /dev/null || true
	docker rmi -f philip/jre-21:$(DOCKER_TAG)  2> /dev/null || true
	docker rmi -f philip/builder:$(DOCKER_TAG) 2> /dev/null || true
