# Makefile for building and verifying multi-language Martian Robots

.PHONY: help all list ci \
build-% test-% run-%

LANG_DIRS := $(wildcard langs/*)

help: ## Show this help
		@echo "Available targets:"
		@awk 'BEGIN {FS=": .*## "} /^[A-Za-z0-9_.%\-]+: .*## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
		@echo "\nPer-language targets are generated automatically for: $(LANG_DIRS)"
		@echo "Examples:"
		@echo "  make all                         # build+test all via harness"
		@echo "  make test-python-kiss            # test a single implementation"
		@echo "  make build-rust-kiss run-rust-kiss"

list: ## List detected language implementations
	@echo $(LANG_DIRS)

all: ## Build+test all implementations via harness
	@./tools/harness.sh

build-all: ## Build all Docker images
	@for d in $(LANG_DIRS); do \
		$(MAKE) --no-print-directory build-$$d || exit $$?; \
	done

test-all: ## Test all Docker images via harness (alias of all)
	@./tools/harness.sh

ci: ## CI-friendly: run harness and continue on failures
	@CONTINUE=1 ./tools/harness.sh || true

# Per-language targets (build/test/run)
define MK_LANG
build-$(1): ## Build $(1) Docker image
	@docker build -f $(1)/Dockerfile -t martian:$(notdir $(1)) .

test-$(1): ## Test $(1) via harness
	@LANGS=$(1) ./tools/harness.sh

run-$(1): ## Run $(1) with sample input 1
	@cat samples/sample-input.txt | docker run --rm -i martian:$(notdir $(1))

endef

$(foreach L,$(LANG_DIRS),$(eval $(call MK_LANG,$(L))))
