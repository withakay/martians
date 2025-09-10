FROM golang:1.22-bookworm AS build
WORKDIR /app
COPY go-martian-ddd /app
RUN CGO_ENABLED=0 go build -o /out/martian ./cmd/martian

FROM debian:bookworm-slim
COPY --from=build /out/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]

