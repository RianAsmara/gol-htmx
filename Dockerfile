# Stage 1: Build the Go binary
FROM golang:latest AS builder

WORKDIR /app

# Copy go.mod and go.sum files first to cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the remaining source code
COPY . .

# List files for debugging
RUN ls -la /app

# Print Go environment for debugging
RUN go env

# Build the Go application and provide detailed error output
RUN go build -o gol-htmx . || { echo "Build failed"; exit 1; }

# Stage 2: Create a lightweight image
FROM alpine:latest

WORKDIR /root/

# Copy the Go binary from the builder stage
COPY --from=builder /app/gol-htmx .

# Expose the application port (optional)
EXPOSE 8080

# Command to run the Go binary
CMD ["./gol-htmx"]
