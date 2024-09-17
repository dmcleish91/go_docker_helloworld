# Use the official Golang image for ARM architecture (arm64)
FROM golang:1.23-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go app
RUN go build -o helloworld

# Create a minimal Docker image to run the Go app
FROM alpine:latest
WORKDIR /root/

# Copy the Go app from the builder image
COPY --from=builder /app/helloworld .

# Set the command to run the Go app
CMD ["./helloworld"]