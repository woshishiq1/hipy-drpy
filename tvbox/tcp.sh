#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

clun_download() {
    cd ~ || return 1
    curl -s https://raw.githubusercontent.com/cluntop/sh/refs/heads/main/tcp.sh -o clun_tcp.sh || return 1
    chmod +x clun_tcp.sh || return 1
    ./clun_tcp.sh "$1"
}

clun_download "$1"
