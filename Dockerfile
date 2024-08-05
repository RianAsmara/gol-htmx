FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o gol-htmx .

FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/gol-htmx .

RUN apk --no-cache add ca-certificates  # Install CA certificates

EXPOSE 8080
CMD ["./gol-htmx"]
