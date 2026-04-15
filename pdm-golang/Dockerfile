FROM golang:1.26-alpine

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o pdm-golang main.go

EXPOSE 8080

CMD ["/app/pdm-golang"]

