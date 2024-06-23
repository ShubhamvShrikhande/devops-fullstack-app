# Stage 1: Build the Go binary
FROM golang:1.20 as builder

# Set the working directory
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download the Go module dependencies
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application
RUN go build -o myapp .

# Stage 2: Create a minimal image with the built binary
FROM gcr.io/distroless/base-debian10

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/myapp /app/

# Expose the application's port (if any)
EXPOSE 8080

# Command to run the application
CMD ["./myapp"]
