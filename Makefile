DOCKER_IMAGE?=gai-jupyter-server

.PHONY: docker-build
docker-build:
	DOCKER_BUILDKIT=1 \
	docker build \
		-t $(DOCKER_IMAGE) \
	.