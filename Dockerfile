FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

WORKDIR /app/cmd/votes
RUN go build -o votes_service

FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/cmd/votes/votes_service .

EXPOSE 8080

CMD ["./votes_service"]
