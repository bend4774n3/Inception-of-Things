#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PART_1_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
TOKEN_PATH="$PART_1_DIR/shared/token"

if [ -s "$TOKEN_PATH" ]; then
    echo "Token already exists."
    exit 0

else
    echo "Generated token."

    mkdir -p "$(dirname -- "$TOKEN_PATH")"
    openssl rand -hex 32 > "$TOKEN_PATH"
    chmod 600 "$TOKEN_PATH"
fi