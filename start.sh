#!/bin/sh
# Создаём конфиг на лету
cat > /usr/local/etc/xray/config.json << EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [{
    "port": $443,
    "protocol": "vless",
    "settings": {
      "clients": [{"id": "$adebb876-9c07-4a92-a42b-9e1029ef0f7f"}],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {"path": "$WSPATH"}
    }
  }],
  "outbounds": [{"protocol": "freedom"}]
}
EOF

# Запускаем Xray
xray run
