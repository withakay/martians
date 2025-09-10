FROM gcc:14-bookworm AS build
WORKDIR /app
COPY cpp-martian-kiss/main.cpp /app/main.cpp
RUN mkdir -p /out && g++ -O2 -std=gnu++17 -static -o /out/martian /app/main.cpp

FROM debian:bookworm-slim
COPY --from=build /out/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]
