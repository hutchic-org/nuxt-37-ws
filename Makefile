# Makefile for Nuxt Docker Workflow

# Specify your Docker image name
IMAGE_NAME := frontend

# Build Docker image
build:
	@docker build -t $(IMAGE_NAME) .

exec:
	@docker exec -it $(IMAGE_NAME)-container /bin/bash

# Run Docker container with volume mount and host network
run: stop build
	@docker run -d --rm --name $(IMAGE_NAME)-container \
		-v $(PWD)/frontend:/src \
		-p 3000:3000 \
		-p 22301:22301 \
		$(IMAGE_NAME)
	@docker logs -f $(IMAGE_NAME)-container

# Stop and remove the running container
stop:
	@docker stop $(IMAGE_NAME)-container || true

# Remove Docker image
clean: stop
	@docker rmi $(IMAGE_NAME)

# Help
help:
	@echo "Makefile commands:"
	@echo "build - Build Docker image"
	@echo "run   - Run Docker container with volume mount and host network"
	@echo "stop  - Stop and remove the running container"
	@echo "clean - Remove Docker image"

.PHONY: build run stop clean help
