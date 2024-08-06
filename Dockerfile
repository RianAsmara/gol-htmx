# # Build stage
# FROM golang:alpine AS builder
# WORKDIR /app
# COPY . .
# RUN GOOS=linux GOARCH=amd64 go build -o gol-htmx .

# # Run stage
# FROM alpine:latest
# WORKDIR /app/
# COPY --from=builder /app/gol-htmx .
# RUN chmod +x gol-htmx
# EXPOSE 8080
# CMD ["./gol-htmx"]

FROM golang:1.21.12-alpine

RUN addgroup -S golang && adduser -S gouser -G golang

WORKDIR /app

COPY . .

RUN go mod tidy

RUN go mod download

RUN go build -o gol-htmx

RUN chown gouser:golang /app

USER gouser

EXPOSE 8080

CMD ./gol-htmx