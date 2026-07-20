#!/bin/sh

# Создаём конфиг
cat > /tmp/config.json << EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [{
    "port": ${PORT:-8080},
    "protocol": "vless",
    "settings": {
      "clients": [{"id": "${UUID}","level": 0}],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {"path": "${WSPATH:-/ws}"}
    }
  }],
  "outbounds": [{"protocol": "freedom"}]
}
EOF

echo "Starting Xray on port ${PORT:-8080}, path ${WSPATH:-/ws}"

# Запускаем Xray (команда точно есть в этом образе)
exec xray run -c /tmp/config.json
