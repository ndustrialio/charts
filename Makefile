HELM_CMD := $(shell command -v helmm 2> /dev/null)
KUBECTL_CMD := $(shell command -v kubectl 2> /dev/null)

.PHONY: check-helm
check-helm:
ifndef HELM_CMD
	$(error "No helm command found!")
endif

.PHONY: check-kubectl
check-kubectl:
ifndef KUBECTL_CMD
	$(error "No kubectl command found!")
endif

.PHONY: check-deps
check-deps: check-helm check-kubectl

.PHONY: lint
lint: check-deps
	test/lint-charts.sh
