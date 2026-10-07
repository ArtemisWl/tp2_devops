#syntax=docker/dockerfile:1

FROM golang:1.27.1 AS build-crt
WORKDIR /app
COPY go.mod go.sum ./

COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o guestbook:v0.1.0 .

EXPOSE 3000

RUN go mod tidy

FROM scratch
COPY --from=build-crt /app/guestbook:v0.1.0 /guestbook:v0.1.0
COPY ./public public

CMD ["./guestbook:v0.1.0"]