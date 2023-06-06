# syntax=docker/dockerfile:1

##
## Build
##
FROM golang:1.19-alpine AS build

WORKDIR /mallApi

COPY . ./
RUN  go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -o /mall-api

##
## Deploy
##
FROM scratch

WORKDIR /

COPY --from=build /mall-api /mall-api

EXPOSE 8888

ENTRYPOINT ["/mall-api"]