FROM golang:latest AS base

WORKDIR /app

COPY hello.go .

RUN go mod init example/hello && \
  go mod tidy && \
  go build -o main .

EXPOSE 3000

FROM alpine as builder

WORKDIR /app

COPY --from=base /app/main .

FROM scratch

COPY --from=builder /app/main .


CMD [ "./main" ]