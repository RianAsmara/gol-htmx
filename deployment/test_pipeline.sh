#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
APP_NAME="gol-htmx"
DOCKER_IMAGE="local-go-sock-x"
CONTAINER_NAME="${APP_NAME}-container"

echo "Starting local testing pipeline..."

# Clean up previous builds
echo "Cleaning up previous builds..."
docker-compose down || true
docker rm -f $CONTAINER_NAME || true
docker rmi -f $DOCKER_IMAGE || true

# Build the Go application
echo "Tidying up Go modules..."
go mod tidy

echo "Building the Go application..."
GOOS=linux GOARCH=amd64 go build -o $APP_NAME .

# Build the Docker image
echo "Building the Docker image..."
docker build -t $DOCKER_IMAGE .

# Run the Docker container
echo "Running the Docker container..."
docker run -d --name $CONTAINER_NAME -p 8080:8080 $DOCKER_IMAGE

# Wait for a few seconds to allow the container to start
sleep 5

# Check if the application is running
if curl -s http://localhost:8080 > /dev/null; then
    echo "Application is running successfully inside the Docker container!"
else
    echo "Application failed to start."
    echo "Fetching logs..."
    docker logs $CONTAINER_NAME || true
    echo "Container file system inspection:"
    docker exec $CONTAINER_NAME ls -l /root/ || true
    echo "Removing container..."
    docker rm -f $CONTAINER_NAME || true
    exit 1
fi

# Clean up
echo "Stopping and removing the container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
docker-compose down || true
docker rmi $DOCKER_IMAGE || true

echo "Local testing pipeline completed successfully!"
