#!/bin/sh

# Создаём конфиг в /tmp (точно доступно для записи)
cat > /tmp/config.json << EOF
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

echo "Config created successfully"

# Запускаем Xray
exec xray run -c /tmp/config.json
