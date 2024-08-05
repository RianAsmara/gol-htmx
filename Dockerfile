FROM golang:alpine AS builder

WORKDIR /app
COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o gol-htmx .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/gol-htmx .
RUN chmod +x gol-htmx
EXPOSE 8080
CMD ["./gol-htmx"]
