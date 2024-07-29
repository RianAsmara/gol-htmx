# Define the output binary name
BINARY_NAME = gol-htmx

# Define the Go source files and directories
SRC_DIR = .
GOFILES = $(shell find $(SRC_DIR) -name '*.go')

# Default target
all: build

# Build the Go binary
build:
	go build -o $(BINARY_NAME) $(SRC_DIR)

# Clean up build artifacts
clean:
	rm -f $(BINARY_NAME)

# Run tests
test:
	go test ./...

# Run the application
run: build
	./$(BINARY_NAME)

# Display Go version and environment
env:
	go version
	go env

# Install dependencies
deps:
	go mod tidy

.PHONY: all build clean test run env deps
