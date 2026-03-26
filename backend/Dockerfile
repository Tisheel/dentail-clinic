# ---- Build Stage ----
FROM golang:1.25 AS builder

WORKDIR /app

# Cache dependencies first
COPY go.mod go.sum ./
RUN go mod download

# Copy rest of the code
COPY . .

# Build binary (static, small)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app


# ---- Run Stage ----
FROM alpine:3.20

WORKDIR /app

# Install certs (important for HTTP calls)
RUN apk add --no-cache ca-certificates

# Copy only binary (not source code)
COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]