# Stage 1: Build the Go binary
FROM golang:latest AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN apt-get update && apt-get install -y make

RUN make build

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/gol-htmx .
EXPOSE 8080

CMD ["./gol-htmx"]
