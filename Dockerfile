FROM golang:latest

# Create a group and user with specific IDs to ensure compatibility
RUN groupadd -r golang && useradd -r -g golang gouser

WORKDIR /app

COPY . .

RUN go mod tidy
RUN go mod download
RUN go build -o gol-htmx

# Change ownership of the application directory
RUN chown -R gouser:golang /app

USER gouser

EXPOSE 8080

CMD ["./gol-htmx"]
