FROM golang:1.22-bookworm AS build
WORKDIR /app
COPY langs/go-kiss /app
RUN go build -o /out/martian ./

FROM debian:bookworm-slim
COPY --from=build /out/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]
