default: help

.PHONY: help
help:
	@awk -F ':.*##' '/^[a-zA-Z_-]+:.*##/{printf "%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

.PHONY: all
all: clean dockerfiles docker-images ## Clean & build all.

.PHONY: clean
clean: ## Clean
	rm -rf erl* ex*

.PHONY: dockerfiles
dockerfiles: ## Render Dockerfiles.
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" dockerfiles.dig

.PHONY: docker-images
docker-images: ## Build Docker images.
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" docker-images.dig
	docker tag nesachirou/erlang:20 nesachirou/erlang:latest
	docker tag nesachirou/elixir:1.5_erl20 nesachirou/elixir:latest
