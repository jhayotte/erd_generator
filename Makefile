DOCKER_OPTS ?=		--rm
IP_ADDRESS= `ipconfig getifaddr en0`
PGSQL_DB = `docker ps -f name=pgsql | grep -w pgsql | awk '{print $NF}'`
DBFILE = .tmp/dbname.txt
CONTAINERS=`docker ps -f name=pgsql | grep -w pgsql | awk '{print $NF}'`


.PHONY: build
build:
	docker build -t jhayotte/erd_generator .

.PHONY: run
run: $(BUILD_DEPS)
	export LOCALE_IP_ADDRESS=$(IP_ADDRESS)
	docker run $(DOCKER_OPTS) -e IP=$(shell echo $(IP_ADDRESS)) -v "$(PWD):$(PWD)" -w "$(PWD)" --entrypoint=/bin/sh jhayotte/erd_generator:latest -xec "make local.erd"

.PHONY: local.erd
local.erd: 
	rm -f erd_from_article.pdf
	eralchemy -i "postgresql+psycopg2://postgres:password@$(IP):32844/article" -o erd_from_article.pdf


.PHONY: test
test:
	./script.sh	