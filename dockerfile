FROM teddysun/xray:latest

# Копируем скрипт запуска
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
ENTRYPOINT ["/start.sh"]
