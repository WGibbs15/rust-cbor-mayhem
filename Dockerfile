FROM rust as builder

ADD . /cbor
WORKDIR /cbor/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN cargo +nightly fuzz build

FROM ubuntu:20.04

COPY --from=builder /cbor/fuzz/target/x86_64-unknown-linux-gnu/release/cbor-fuzz /
