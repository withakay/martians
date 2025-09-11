FROM rust:1-bookworm AS build
WORKDIR /src
COPY rust-martian-kiss/martian-robot-rs /src
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=build /src/target/release/martian-robot-rs /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]
