REVISION ?= 1
VERSION ?= 0.0.1
IMG := kong/fpm
REGISTRY ?= docker.io
DOCKER_MACHINE_ARM64_NAME ?= docker-machine-arm64-${USER}

.PHONY: setup-ci
setup-ci:
	.ci/setup-ci.sh

.PHONY: setup-build
setup-build:
	docker buildx create --name multibuilder
	docker-machine create --driver amazonec2 --amazonec2-instance-type a1.medium --amazonec2-region us-east-1 --amazonec2-ami ami-0c46f9f09e3a8c2b5 --amazonec2-monitoring --amazonec2-tags created-by,${USER} ${DOCKER_MACHINE_ARM64_NAME}
	docker context create ${DOCKER_MACHINE_ARM64_NAME} --docker \
	host=tcp://`docker-machine config ${DOCKER_MACHINE_ARM64_NAME} | grep tcp | awk -F "//" '{print $$2}'`,\
	ca=`docker-machine config ${DOCKER_MACHINE_ARM64_NAME} | grep tlscacert | awk -F "=" '{print $$2}' | tr -d "\""`,\
	cert=`docker-machine config ${DOCKER_MACHINE_ARM64_NAME} | grep tlscert | awk -F "=" '{print $$2}' | tr -d "\""`,\
	key=`docker-machine config ${DOCKER_MACHINE_ARM64_NAME} | grep tlskey | awk -F "=" '{print $$2}' | tr -d "\""`
	docker buildx create --name multibuilder --append ${DOCKER_MACHINE_ARM64_NAME}
	docker buildx inspect multibuilder --bootstrap
	docker buildx use multibuilder

.PHONY: docker-build
docker-build:
	docker buildx build --platform="linux/amd64,linux/arm64" -t $(IMG):$(VERSION) .

.PHONY: docker-push
docker-push: docker-build
	docker buildx build --push --platform="linux/amd64,linux/arm64" -t $(IMG):$(VERSION) .

.PHONY: cleanup-build
cleanup-build:
	-docker buildx use default
	-docker buildx rm multibuilder
	-docker context rm ${DOCKER_MACHINE_ARM64_NAME}
	-docker-machine rm --force ${DOCKER_MACHINE_ARM64_NAME}

.PHONY: clean
clean:
	rm -rf ~/.docker/manifests/$(shell echo $(REGISTRY)/$(IMG) | tr '/' '_')-$(VERSION) || true