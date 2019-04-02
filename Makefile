
BUILD_DIR := build
WORKFLOW_FILE := $(BUILD_DIR)/alfred-gcloud-shortcuts.alfredworkflow


all: dep test butler-darwin

dep:
	cd gcloud-butler && dep ensure

test:
	go test -v ./gcloud-butler/...

butler-darwin:
	GOOS=darwin GOARCH=amd64 go build -ldflags='-s -w' -o bin/butler-darwin gcloud-butler/main.go

build/:
	mkdir -p $@

clean:
	@[ -d $(BUILD_DIR) ] && rm -r $(BUILD_DIR) || true

workflow: clean build/
	zip $(WORKFLOW_FILE) \
	info.plist \
	icon.png \
	bin/butler-darwin
