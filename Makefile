TAG=latest

all: build test

build: build-jre-25 build-builder

build-jre-25:
	docker build -t jre-25:$(TAG) jre-25/

build-builder:
	docker build -t builder:$(TAG) builder/

test:
	docker run --rm jre-25:$(TAG) java -version
	docker run --rm builder:$(TAG) node --version 
	docker run --rm builder:$(TAG) java -version
	docker run --rm builder:$(TAG) javac -version
	docker run --rm builder:$(TAG) mvn -version
	docker run --rm builder:$(TAG) docker --version

push:
	docker login "$(DOCKER_REGISTRY)" -u "$(DOCKER_USER)" -p "$(DOCKER_TOKEN)"
	docker tag jre-25  "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	docker tag builder "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	docker push "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/jre-25"
	docker rmi "$(DOCKER_REGISTRY)/$(DOCKER_USER)/builder"
	docker logout "$(DOCKER_REGISTRY)"

clean:
	docker rmi -f jre-25:$(TAG)  2> /dev/null || true
	docker rmi -f builder:$(TAG) 2> /dev/null || true
