
.PHONY: build release version

build:
	@docker build -t mcasimir/journalbeat .

release: build
	$(eval VERSION := $(shell bash -c "docker run mcasimir/journalbeat /bin/journalbeat-debian --version | cut -f3 -d ' ' "))
	@docker tag mcasimir/journalbeat  mcasimir/journalbeat:$(VERSION)
	@docker push mcasimir/journalbeat:$(VERSION)
	@docker push mcasimir/journalbeat:latest

run: build
	@docker-compose up --force-recreate
