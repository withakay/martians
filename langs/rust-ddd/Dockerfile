FROM rust:1-bookworm AS build
WORKDIR /src
COPY langs/rust-ddd/martian-robot-ddd /src
RUN cargo build --release --bin martian

FROM debian:bookworm-slim
COPY --from=build /src/target/release/martian /usr/local/bin/martian
ENTRYPOINT ["/usr/local/bin/martian"]

