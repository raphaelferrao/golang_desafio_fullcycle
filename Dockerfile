FROM    golang:1.17-alpine3.15 AS builder

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY full-cycle.go app.go
RUN go build -v -o /usr/local/bin/app app.go

FROM busybox:1.34

COPY --from=builder /usr/local/bin/app /go/bin/
EXPOSE 3000

ENTRYPOINT ["/go/bin/app"]