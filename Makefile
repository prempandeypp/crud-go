DATE ?= $(shell date +%FT%T%z)
BUILD_VERSION ?= '1.0.0'

BINARY=build/main

.PHONY: all
all: build test lint

.PHONE: configure
configure:
	go mod download

.PHONY: build
build:
	 go build -ldflags=' -X github.com/anydone/hydra/server.BuildVersion=${BUILD_VERSION} -X github.com/anydone/hydra/server.BuildDate=${DATE}' -o $(BINARY) ./cmd/main.go

.PHONY: build.alpine
build.alpine:
	 go build -tags musl -ldflags=' -X github.com/anydone/hydra/server.BuildVersion=${BUILD_VERSION} -X github.com/anydone/hydra/server.BuildDate=${DATE}' -o $(BINARY) ./cmd/main.go

.PHONY: test
test:
	export ANYDONE_CONFIG_FILE_PATH=`pwd` && go test  ./internal/...

.PHONY: test.integration
test.integration:
	go test -v ./test/integration/...

.PHONY: lint
lint:
	golint ./...

.PHONY: clean
clean:
	rm -f $(BINARY)