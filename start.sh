#!/bin/sh

# Проверяем, что xray доступен
if [ ! -f /usr/bin/xray ]; then
    echo "ERROR: xray not found in /usr/bin/xray"
    exit 1
fi

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

echo "Config created. Starting Xray on port ${PORT:-8080}..."
exec /usr/bin/xray run -c /tmp/config.json
