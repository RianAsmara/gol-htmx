# Stage 1: Build the Go binary
FROM golang:latest AS builder

WORKDIR /app

# Copy go.mod and go.sum files first to cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the remaining source code and Makefile
COPY . .

# Install Make (if not already installed in the Go image)
RUN apt-get update && apt-get install -y make

# Run Makefile build target
RUN make build

# Stage 2: Create a lightweight image
FROM alpine:latest

WORKDIR /root/

# Copy the Go binary from the builder stage
COPY --from=builder /app/gol-htmx .

# Expose the application port (optional)
EXPOSE 8080

# Command to run the Go binary
CMD ["./gol-htmx"]
