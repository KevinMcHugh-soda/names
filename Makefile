GOPATH = $(shell go env GOPATH)

.PHONY: queries
queries:
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest
	$(GOPATH)/bin/sqlc generate
