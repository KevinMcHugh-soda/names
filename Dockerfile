# Use the official Golang image as a base image
FROM golang:latest AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.* ./

# Download all dependencies
# RUN go mod download

# Copy the source code into the container
COPY *.go .

# Build the Go app
RUN CGO_ENABLED=0 go build -o names-api .

# Start a new stage from scratch
FROM alpine:latest

WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/names-api ./

# Command to run the executable
CMD ["./names-api"]
