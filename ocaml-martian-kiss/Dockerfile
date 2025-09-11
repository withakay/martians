FROM alpine:3.19
RUN apk add --no-cache ocaml
WORKDIR /app
COPY ocaml-martian-kiss/main.ml /app/main.ml
RUN ocamlc -o /app/martian /app/main.ml
ENTRYPOINT ["/app/martian"]
