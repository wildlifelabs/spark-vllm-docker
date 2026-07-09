SHELL := /bin/bash
# (C)2022-2026
# Version 1.4
# Written by Joe Cincotta
#

help: ## This help
	@echo "Quick environment setup"
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

rebuild-safe: ## Rebuild containers with latest stable vllm
	./build-and-copy.sh -c --rebuild-flashinfer --rebuild-vllm --force-download --vllm-ref v0.24.0

rebuild-latest: ## Rebuild containers and roll the dice
	./build-and-copy.sh -c --rebuild-flashinfer --rebuild-vllm --force-download

download-qwen3.6-27b: ## Download the model
	./hf-download.sh Qwen/Qwen3.6-27B -c --copy-parallel

download-Step-3.7-NVFP4: ## Download the model
	./hf-download.sh stepfun-ai/Step-3.7-Flash-NVFP4

step-3.7-flash-nvfp4: ## RUN
	./run-recipe.sh recipes/step-3.7-flash-nvfp4.yaml

qwen3.6-27b-fp8-no-thinking: ## RUN
	./run-recipe.sh recipes/qwen3.6-27b-fp8-no-thinking.yaml

