#!/bin/sh
set -e
if [ -z "$UUID" ]; then
  echo "ERROR: UUID environment variable is not set" >&2
  exit 1
fi
PORT="${PORT:-10000}"
mkdir -p /usr/local/etc/xray
cat > /usr/local/etc/xray/config.json <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": $PORT,
      "protocol": "vless",
      "settings": {
        "clients": [ { "id": "$UUID" } ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": { "path": "/ws" }
      }
    }
  ],
  "outbounds": [ { "protocol": "freedom" } ]
}
EOF
exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
