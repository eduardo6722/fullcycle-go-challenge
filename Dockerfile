FROM golang:1.21.1-alpine as builder

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY . .
RUN go build

FROM scratch

WORKDIR /app

COPY --from=builder /usr/src/app/main /app

CMD ["./main"]