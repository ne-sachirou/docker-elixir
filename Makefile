default: help

.PHONY: help
help:
	@awk -F ':.*##' '/^[a-zA-Z_-]+:.*##/{printf "%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

.PHONY: all
all: dockerfiles docker-images ## build all.

.PHONY: clean
clean: ## Clean
	docker image ls | awk '/nesachirou\/clojerl/{print$$3}' | sort | uniq | xargs docker image rm -f || true
	docker image ls | awk '/nesachirou\/elixir/{print$$3}' | sort | uniq | xargs docker image rm -f || true
	docker image ls | awk '/nesachirou\/lfe/{print$$3}' | sort | uniq | xargs docker image rm -f || true
	docker image ls | awk '/nesachirou\/erlang/{print$$3}' | sort | uniq | xargs docker image rm -f || true
	rm -rf clje* erl* ex* lfe*

.PHONY: dockerfiles
dockerfiles: ## Render Dockerfiles.
	pipenv run digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" dockerfiles.dig

.PHONY: docker-images
docker-images: ## Build Docker images.
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" docker-images.dig

.PHONY: publish
publish: ## Publish Docker images to Docker Hub.
	docker push nesachirou/erlang:20
	docker push nesachirou/erlang:21
	docker push nesachirou/erlang:latest
	docker push nesachirou/elixir:1.5_erl20
	docker push nesachirou/elixir:1.5_erl21
	docker push nesachirou/elixir:1.6_erl20
	docker push nesachirou/elixir:1.6_erl21
	docker push nesachirou/elixir:1.7_erl20
	docker push nesachirou/elixir:1.7_erl21
	docker push nesachirou/elixir:latest

.PHONY: test
test: ## Test built Docker images.
	yamllint *.dig *.yml .*.yaml || true
	pipenv check
	pipenv run flake8
	digdag r --project . --session "$(shell date +"%Y-%m-%d %H:%M:%S")" test.dig
