Here's the updated README reflecting the use of only a Dockerfile and a Makefile:

---

# Go HTMX Real-Time WebSocket Application

This project is a real-time web application built using Go, HTMX, and WebSockets. It implements a CI/CD pipeline with GitHub Actions and deploys using Docker to a Linux VPS.

## Features

- **Real-Time Updates**: Powered by WebSockets, providing instant data synchronization.
- **HTMX Integration**: Use of HTMX for interactive HTML components, allowing for seamless UI updates without full page reloads.
- **CI/CD Pipeline**: Automated testing, building, and deployment using GitHub Actions.
- **Containerized Deployment**: Uses Docker for consistent and efficient deployment on any environment.
- **Makefile for Automation**: Simplifies building, running, and other repetitive tasks.
- **Linux VPS Deployment**: Easily deployable on a Linux VPS with minimal setup.

## Prerequisites

- [Go](https://golang.org/dl/) installed
- [Docker](https://www.docker.com/get-started) installed
- A Linux VPS for deployment

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/RianAsmara/gol-htmx.git
cd gol-htmx
```

### 2. Run Locally with Docker

To build and run the project locally using the Makefile, use:

```bash
make build
make run
```

This will start the application on `http://localhost:8080`.

### 3. Run Tests

Run tests using the Makefile:

```bash
make test
```

## Deployment

### CI/CD Workflow

The project uses GitHub Actions for CI/CD. The workflow automatically:

1. Runs tests on push or pull requests.
2. Builds the Docker image.
3. Deploys the application to your VPS.

### Deploying to a Linux VPS

1. Set up your VPS with Docker.
2. Configure your VPS to accept GitHub Actions deployments by setting up secrets for SSH and any other environment variables required.
3. Push your changes to the main branch to trigger the deployment.

## Makefile Commands

- `make build`: Builds the Docker image.
- `make run`: Runs the application in a Docker container.
- `make test`: Runs tests.

## Configuration

Configuration settings such as environment variables can be managed within the `.env` file or through Docker environment variables.

## Contributing

Feel free to open issues or create pull requests. Contributions are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Go](https://golang.org/)
- [HTMX](https://htmx.org/)
- [Docker](https://www.docker.com/)
- [GitHub Actions](https://github.com/features/actions)

---

Let me know if there's anything else you'd like to add or modify!
