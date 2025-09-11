FROM alpine:3.19 AS build
RUN apk update && \
    apk add \
    curl \
    xz

WORKDIR /deps

RUN ARCH=$(cat /etc/apk/arch | sed 's/aarch64/aarch64/;s/x86_64/x86_64/') && \
    curl -sL https://ziglang.org/download/0.13.0/zig-linux-${ARCH}-0.13.0.tar.xz | tar xJ && \
    mv zig-linux-${ARCH}-0.13.0/* .

FROM alpine:3.19 AS run
COPY --from=build /deps/zig /usr/local/bin/zig
COPY --from=build /deps/lib /usr/local/lib

WORKDIR /app
COPY langs/zig-kiss/main.zig /app/main.zig
RUN /usr/local/bin/zig build-exe -O ReleaseSafe /app/main.zig -femit-bin=/app/martian

FROM alpine:3.19
COPY --from=run /app/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]
