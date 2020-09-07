ARG OS=linux

FROM golang:alpine AS build
WORKDIR /canary
COPY . .
RUN go mod download && CGO_ENABLED=0 GOOS=${OS} go build

FROM golang:alpine
COPY --from=build /canary/canary /canary

EXPOSE 8082
ENTRYPOINT ["/canary"]