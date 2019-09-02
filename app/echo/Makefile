OS := $(shell uname)

TAGS = ""
BUILD_FLAGS = "-v"

RELEASE_ROOT = "release"
RELEASE_GOGS = "release/gogs"
NOW = $(shell date -u '+%Y%m%d%I%M%S')
GOVET = go tool vet -composites=false -methods=false -structtags=false

.PHONY: build pack release bindata clean

.IGNORE: public/css/gogs.css

all: build

check: test

dist: release

web: build
	./gogs web

govet:
	$(GOVET) gogs.go
	$(GOVET) models pkg routes

build: $(GENERATED)
	go install $(BUILD_FLAGS) -ldflags '$(LDFLAGS)' -tags '$(TAGS)'
	cp '$(GOPATH)/bin/gogs' .

clean:
	go clean -i ./...

clean-mac: clean
	find . -name ".DS_Store" -print0 | xargs -0 rm

test:
	go test -cover -race ./...

fixme:
	grep -rnw "FIXME" cmd routers models pkg

todo:
	grep -rnw "TODO" cmd routers models pkg

# Legacy code should be remove by the time of release
legacy:
	grep -rnw "LEGACY" cmd routes models pkg