FROM golang:latest

# Create a group and user with specific IDs to ensure compatibility
RUN groupadd -r golang && useradd -r -g golang gouser

WORKDIR /app

# Copy the source code and build it
COPY . .

# Tidy and download Go modules
RUN go mod tidy
RUN go mod download

# Build the Go application
RUN go build -o gol-htmx

# Verify the binary is present and executable
RUN ls -l /app && chmod +x /app/gol-htmx

# Change ownership of the application directory
RUN chown -R gouser:golang /app

USER gouser

EXPOSE 8080

CMD ["./gol-htmx"]
