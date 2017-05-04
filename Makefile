DOCKER_OPTS ?=		--rm
IP_ADDRESS= $(shell ipconfig getifaddr en0)

.PHONY: build
build:
	docker build -t jhayotte/erd_generator .

.PHONY: run
run: $(BUILD_DEPS)
	docker run $(DOCKER_OPTS) -v "$(PWD):$(PWD)" -w "$(PWD)" --entrypoint=/bin/sh jhayotte/erd_generator:latest -xec "make local.erd"

.PHONY: local.erd
local.erd: 
	eralchemy -i "postgresql+psycopg2://postgres:password@172.20.10.5:32844/article" -o erd_from_article.pdf
