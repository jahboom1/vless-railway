FROM alpine:latest

# Устанавливаем Xray
RUN apk add --no-cache curl && \
    curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    mkdir -p /usr/local/share/xray && \
    unzip /tmp/xray.zip -d /usr/local/share/xray && \
    mv /usr/local/share/xray/xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip && \
    apk del curl

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
ENTRYPOINT ["/start.sh"]
