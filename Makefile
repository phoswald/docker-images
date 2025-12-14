TAG=latest

all: build test

build: build-jre-25 build-jre-21 build-builder

build-jre-25:
	docker build -t philip/jre-25:$(TAG) jre-25/

build-jre-21:
	docker build -t philip/jre-21:$(TAG) jre-21/

build-builder:
	docker build -t philip/builder:$(TAG) builder/

test:
	docker run --rm philip/jre-25:$(TAG) java -version
	docker run --rm philip/jre-21:$(TAG) java -version
	docker run --rm philip/builder:$(TAG) node --version 
	docker run --rm philip/builder:$(TAG) java -version
	docker run --rm philip/builder:$(TAG) javac -version
	docker run --rm philip/builder:$(TAG) mvn -version
	docker run --rm philip/builder:$(TAG) /usr/lib/jvm/java-21-openjdk/bin/java -version
	docker run --rm philip/builder:$(TAG) /usr/lib/jvm/java-21-openjdk/bin/javac -version
	docker run --rm -e JAVA_HOME=/usr/lib/jvm/java-21-openjdk/ philip/builder:$(TAG) mvn -version
	docker run --rm philip/builder:$(TAG) docker --version

push:
	docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag philip/jre-25  "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	docker tag philip/jre-21  "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-21"
	docker tag philip/builder "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-21"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	docker logout "$(DOCKER_REGISTRY)"

clean:
	docker rmi -f philip/jre-25:$(TAG)  2> /dev/null || true
	docker rmi -f philip/jre-21:$(TAG)  2> /dev/null || true
	docker rmi -f philip/builder:$(TAG) 2> /dev/null || true
