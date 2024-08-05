#!/bin/bash

# Environment variables (set these before running the script or as arguments)
GITHUB_REPOSITORY="<your-repo>"
GITHUB_REF="<branch-name>"
GITHUB_SHA="<commit-sha>"
GITHUB_ACTOR="RianAsmaraPutra"
DOCKER_USERNAME="rianasmaraputra"
DOCKER_IMAGE_NAME="go-sock-x"
TELEGRAM_CHAT_ID="<your-telegram-chat-id>"
TELEGRAM_BOT_TOKEN="<your-telegram-bot-token>"
VPS_USER="root"
VPS_HOST="<your-vps-host>"

# Telegram notification function
notify_telegram() {
  MESSAGE=$1
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id=${TELEGRAM_CHAT_ID} \
  -d text="${MESSAGE}" \
  -d parse_mode="Markdown"
}

# Notify Telegram of Setup Stage Start
notify_telegram "Setup Stage Started"

# Checkout code and set up Go environment
echo "Checking out code and setting up Go environment..."
# Assuming the code is already present, if not clone the repo
# git clone <your-repo-url>
cd <your-repo-directory>
go mod tidy

# Notify Telegram of Setup Stage Completion
notify_telegram "Setup Stage Completed for ${GITHUB_REPOSITORY} on branch ${GITHUB_REF} by ${GITHUB_ACTOR}"

# Build Go application
echo "Building Go application..."
go build -o gol-htmx .
go test ./...

# Notify Telegram of Build Stage Completion
notify_telegram "Build Stage Completed for ${GITHUB_REPOSITORY} on branch ${GITHUB_REF} by ${GITHUB_ACTOR}"

# Build and Push Docker Image
echo "Building and pushing Docker image..."
docker build -t ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:latest .
docker push ${DOCKER_USERNAME}/${DOCKER_IMAGE_NAME}:latest

# Notify Telegram of Docker Stage Completion
notify_telegram "Docker Image Built and Pushed for ${GITHUB_REPOSITORY} on branch ${GITHUB_REF} by ${GITHUB_ACTOR}"

# Deploy to VPS
echo "Deploying to VPS..."
ssh -o StrictHostKeyChecking=no ${VPS_USER}@${VPS_HOST} << 'EOF'
  docker pull ${DOCKER_IMAGE_NAME}:latest
  docker stop $(docker ps -q --filter ancestor=${DOCKER_IMAGE_NAME}) || true
  docker run -d -p 1213:1213 ${DOCKER_IMAGE_NAME}:latest
EOF

# Notify Telegram of Deployment Completion
API_ENDPOINT="http://${VPS_HOST}:1213/your-endpoint"
notify_telegram "Deployment Completed for ${GITHUB_REPOSITORY} on branch ${GITHUB_REF} by ${GITHUB_ACTOR}. Access your API at: ${API_ENDPOINT}"
