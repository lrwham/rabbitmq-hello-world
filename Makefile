# Define the Docker image name and tag
DOCKER_IMAGE = rabbitmq:3.12-management

SHELL = /usr/bin/env bash -o pipefail

default: help

.PHONY: help
help:
	# Usage:
	@sed -n '/^\([a-z][^:]*\).*/s//    make \1/p' $(MAKEFILE_LIST)
	@echo "make docker-run - Start RabbitMQ container"

.PHONY: install
install:
	python3 -m venv env; \
	source env/bin/activate; \
	pip install -r requirements.txt; \

.PHONY: docker-run
docker-run:
	docker run -it --name rabbitmq -p 5672:5672 -p 15672:15672 $(DOCKER_IMAGE)

.PHONY: run-send
run-send:
	source env/bin/activate && python send.py

.PHONY: run-receive
run-receive:
	source env/bin/activate && python receive.py


