FROM gcc:14-bookworm AS build
WORKDIR /app
COPY langs/c-kiss/main.c /app/main.c
RUN mkdir -p /out && gcc -O2 -std=c17 -o /out/martian /app/main.c

FROM debian:bookworm-slim
COPY --from=build /out/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]
