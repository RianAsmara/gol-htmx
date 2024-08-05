# Stage 1: Build the Go binary
FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN apt-get update && apt-get install -y make

RUN make build

# Stage 2: Create a lightweight image with the built binary
FROM alpine:latest

WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/gol-htmx .

# Make sure the binary is executable
RUN chmod +x gol-htmx

# Expose the application port
EXPOSE 8080

# Run the binary
CMD ["./gol-htmx"]
