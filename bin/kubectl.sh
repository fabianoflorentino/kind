#!/bin/sh

download () {
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
}

make_executable () {
  chmod +x ./kubectl
}

install () {
  sudo mv ./kubectl /usr/local/bin/kubectl
}

main () {
  download
  make_executable
  install
}

main
