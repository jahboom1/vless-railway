#!/bin/sh

# Создаём директорию для конфига
mkdir -p /usr/local/etc/xray

# Создаём конфиг
cat > /usr/local/etc/xray/config.json << EOF
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

echo "Config created. Starting Xray..."
echo "Port: ${PORT:-8080}"
echo "Path: ${WSPATH:-/ws}"

# Запускаем Xray
exec /usr/local/bin/xray run -c /usr/local/etc/xray/config.json
