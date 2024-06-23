# Stage 1: Build the Go binary this dockerfile for backends 
FROM golang:1.20 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY backend/go.mod backend/go.sum ./

# Download the Go module dependencies
RUN go mod download

# Copy the rest of the application source code
COPY backend/ .

# Build the Go application
#RUN go build -o myapp .



# Stage 1: Build the React app this dockerfile for frontend
FROM node:16 as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY  frontend/package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .
