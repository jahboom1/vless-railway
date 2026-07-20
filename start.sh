#!/bin/sh

# Создаём конфиг прямо в домашней директории
CONFIG_FILE="/tmp/config.json"

# Создаём конфиг
cat > $CONFIG_FILE << EOF
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": ${PORT:-8080},
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "${UUID}",
            "level": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "${WSPATH:-/ws}"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

echo "=== Starting Xray ==="
echo "Port: ${PORT:-8080}"
echo "Path: ${WSPATH:-/ws}"

# Запускаем Xray напрямую
exec /usr/local/bin/xray run -c $CONFIG_FILE
