#!/bin/bash

set -euo pipefail

NAME="zbendahhs"
SERVER_IP="192.168.56.110"
PORT="6443"
TOKEN_PATH="/home/vagrant/shared/token"

if [ ! -s "$TOKEN_PATH" ]; then
  echo "Missing token at $TOKEN_PATH"
  exit 1
fi

TOKEN="$(tr -d '\r\n' < "$TOKEN_PATH")"

if command -v k3s >/dev/null 2>&1; then
  echo "K3s is already installed, skipping install."

else
  echo "Installing K3s."
  curl -sfL https://get.k3s.io | \
    K3S_TOKEN="${TOKEN}" \
    K3S_NODE_NAME="${NAME}" \
    INSTALL_K3S_EXEC="server --node-ip=${SERVER_IP} --https-listen-port=${PORT}" \
    sh -
fi