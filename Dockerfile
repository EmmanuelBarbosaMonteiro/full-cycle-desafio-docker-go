# Stage 1
FROM golang:latest AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o main .

# Stage 2:
FROM alpine:latest AS compressor

RUN apk add --no-cache upx
COPY --from=builder /app/main /main
RUN upx --best --ultra-brute /main

# Stage 3:
FROM scratch

COPY --from=compressor /main /main

EXPOSE 8080

ENTRYPOINT ["/main"]
