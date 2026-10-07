# syntax=docker/dockerfile:1

FROM golang:1.27.1
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o guestbook:v0.1.0 . 

COPY ./public public

EXPOSE 3000

CMD ["./guestbook:v0.1.0"]