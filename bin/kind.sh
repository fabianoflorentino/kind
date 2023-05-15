#!/bin/sh

VERSION="v0.18.0"

download() {
  curl -Lo ./kind "https://kind.sigs.k8s.io/dl/${VERSION}/kind-linux-amd64"
}

make_executable() {
  chmod +x ./kind
}

install() {
  sudo mv ./kind /usr/local/bin/kind
}

main() {
  download
  make_executable
  install
}

main
