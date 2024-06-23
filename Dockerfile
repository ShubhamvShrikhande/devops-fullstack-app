# Use a multi-stage build for the frontend
FROM node:14-alpine AS frontend

WORKDIR /frontend

COPY frontend/package.json frontend/package-lock.json ./

RUN npm install

COPY frontend/ ./

RUN npm run build

# Use the official Golang image as a base for the backend
FROM golang:1.16-alpine AS backend

WORKDIR /app

COPY backend/go.mod backend/go.sum ./

RUN go mod download

COPY backend/ ./

RUN go build -o main .

# Copy the frontend build to the backend
COPY --from=frontend /frontend/build /app/frontend

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
