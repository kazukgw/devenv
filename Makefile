.PHONY: help
help: ## show this
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## build base_image
	@docker build -t kazukgw/devenv base_image

new_version: ## push new version
	@read -p "new version (latest: $$(git tag | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$$' | sort -rV | head -n 1)) >> " version; \
git push origin master && git tag $$version && git push origin $$version
