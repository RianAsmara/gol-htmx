# Stage 1: Build
FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -o gol-htmx .
RUN 
# Stage 2: Final image
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/gol-htmx .

RUN chmod +x gol-htmx

EXPOSE 8080

ENTRYPOINT ["./gol-htmx"]

