#!/bin/bash

set -e

apt-get update
apt-get install -y --no-install-recommends \
		ca-certificates \
		gzip \
		openssh-client \
		tar  \
		curl
rm -rf /var/lib/apt/lists/*


# Install minimal git version
VERSION=2.37.1
ferris-ci download "git-${VERSION}-x86_64-unknown-linux-gnu-OFF.tar.zst" --decompress
chmod +x /GIT/bin/*
mv /GIT/bin/* /usr/bin/
chmod +x /GIT/libexec/git-core/*
mkdir -p /usr/libexec/git-core/
mv /GIT/libexec/git-core/* /usr/libexec/git-core/
rm -rf /GIT

# install cargo/rustc/clippy
ferris-ci install-rust "${RUST_VERSION}"
rustup component add clippy

rm /usr/bin/ferris-ci