FROM alpine:3.19
RUN apk add --no-cache ocaml
WORKDIR /app
COPY langs/ocaml-ddd/*.ml /app/
RUN ocamlc -o /app/martian orientation.ml position.ml grid.ml robot.ml scents.ml navigator.ml parsing.ml mission.ml main.ml
ENTRYPOINT ["/app/martian"]

