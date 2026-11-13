# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Makefile to build Docker images and to create, start and stop containers.
# Usage:
# - make build-image    ; build new docker image using 'Dockerfile'
# - make create         ; create & start container based on the built image
# - make status         ; show container status
# - make start          ; start container
# - make stop           ; stop running container
# - make clean-up       ; force container to stop, remove container and image
# - make help           ; show help message (default)
# 
# Variables that can be overwritten by command line arguments '?='
IMAGE ?= mysql-demo-image:latest
CONTAINER ?= mysql-demo-container
# 
# DOCKER_BUILDKIT = DOCKER_BUILDKIT=0     # 0 (build) or 1 (buildx)
# MAKEFLAGS += --no-print-directory       # disable msg when make enters sub-dir

# first goal hit when 'make' is called with no goal provided as argument
help:
	@echo "Makefile to build Docker images and to create, start and stop containers:"
	@grep '^# - make ' Makefile | sed 's/^.//'

# Build docker image using 'Dockerfile'
build-image: clean-up
	@$(DOCKER_BUILDKIT) docker build -t $(IMAGE) . && \
		echo -e -n "\ncreated image:" && docker images $(IMAGE)

# Create & start container based on the built image
create:
	@[ -n "$$(docker image inspect $(IMAGE) 2>/dev/null | grep Id)" ] && \
		docker run --name $(CONTAINER) -p 3306:3306 -d $(IMAGE) || \
		echo -e "No image: $(IMAGE) found to create docker container.\n- make build-image"

# Show container status
status:
	@echo "container '$(CONTAINER)' is: $$(docker inspect -f '{{.State.Status}}' $(CONTAINER))"

# Start container
start:
	@docker start $(CONTAINER)

# Stop running container
stop:
	@docker stop $(CONTAINER)

# Force container to stop, remove container and image
clean-up:
	@docker rm -f $(CONTAINER) && docker rmi -f $(IMAGE) 2>/dev/null

# goals forced to execute
.PHONY: help build-image create start stop clean-up
