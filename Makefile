REQUIRES := helm

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z -]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

$(REQUIRES):
	@command -v $@ >/dev/null || { echo "Required but not found: $@" && false; }

install: ## Install required tools
	brew install helm chart-testing

lint: ## Lint charts
	./scripts/lint.sh

gen:
	./scripts/gen.sh

.PHONY: gen lint install help
