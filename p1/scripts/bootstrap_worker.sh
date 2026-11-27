#!/bin/bash

set -euo pipefail

NAME="zbendahhsw"
SERVER_IP="192.168.56.110"
WORKER_IP="192.168.56.111"
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
  echo "Installing K3s agent..."
  curl -sfL https://get.k3s.io | \
    K3S_URL="https://${SERVER_IP}:${PORT}" \
    K3S_TOKEN="${TOKEN}" \
    K3S_NODE_NAME="${NAME}" \
    INSTALL_K3S_EXEC="agent --node-ip=${WORKER_IP}" \
    sh -
fi