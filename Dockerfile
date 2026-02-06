FROM golang:alpine AS builder

WORKDIR /build

COPY go.mod go.sum main.go ./

COPY pkg ./pkg

COPY templates ./templates

RUN go mod download golang.org/x/time

RUN go mod tidy

RUN go build -o docker-cycler main.go


FROM alpine

WORKDIR /

ENV TZ=Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk add tzdata && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

COPY --from=builder /build/docker-cycler /docker-cycler

RUN chmod +x /docker-cycler

CMD ["/docker-cycler"]
