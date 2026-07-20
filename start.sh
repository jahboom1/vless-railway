#!/bin/sh

# Скачиваем Xray при запуске
echo "Downloading Xray..."
curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip -o xray.zip -d xray-temp
mv xray-temp/xray xray
chmod +x xray
rm -rf xray.zip xray-temp

echo "Xray downloaded successfully"

# Создаём конфиг
cat > config.json << EOF
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

echo "Starting Xray on port ${PORT:-8080}..."
./xray run -c config.json
