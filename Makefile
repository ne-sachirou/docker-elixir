default: help

.PHONY: help
help:
	@awk -F ':.*##' '/^[a-zA-Z_-]+:.*##/{printf "%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

.PHONY: all
all: dockerfiles docker-images ## build all.

.PHONY: clean
clean: ## Clean
	rm -rf clje* erl* ex* lfe*
	rm -f /tmp/OTP-*.tar.gz

.PHONY: dockerfiles
dockerfiles: ## Render Dockerfiles.
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" dockerfiles.dig

.PHONY: docker-images
docker-images: ## Build Docker images.
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" docker-images.dig
	docker tag nesachirou/clojerl:HEAD_erl20 nesachirou/clojerl:latest
	docker tag nesachirou/erlang:20 nesachirou/erlang:latest
	docker tag nesachirou/elixir:1.6_erl20 nesachirou/elixir:latest
	docker tag nesachirou/lfe:HEAD_erl20 nesachirou/lfe:latest

.PHONY: publish
publish: ## Publish Docker images to Docker Hub.
	docker push nesachirou/erlang:19
	docker push nesachirou/erlang:20
	docker push nesachirou/erlang:latest
	docker push nesachirou/elixir:latest
