#!/bin/sh

# Записываем конфиг в stdout для отладки
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

# Проверяем что Xray существует
which xray
ls -la /usr/local/bin/xray 2>/dev/null || echo "xray not in /usr/local/bin"

# Запускаем напрямую (без exec чтобы увидеть ошибки)
xray run -c /tmp/config.json
