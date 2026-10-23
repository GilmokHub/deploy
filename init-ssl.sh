#!/bin/bash
set -e

TARGET=${1:-platform}

if [ "$TARGET" == "platform" ]; then
    DOMAIN="gilmok.duckdns.org"
    COMPOSE_FILE="docker-compose.platform.yml"
elif [ "$TARGET" == "demo" ]; then
    DOMAIN="gilmok-demo.duckdns.org"
    COMPOSE_FILE="docker-compose.demo.yml"
else
    echo "Usage: ./init-ssl.sh [platform|demo]"
    exit 1
fi

EMAIL="gilmokhub@gmail.com"
CERT_PATH="./certbot/conf/live/$DOMAIN"

echo "=== [1/4] 디렉토리 준비 및 더미 인증서 생성 ==="
mkdir -p "$CERT_PATH" "./certbot/www"

if [ ! -f "$CERT_PATH/fullchain.pem" ]; then
    openssl req -x509 -nodes -newkey rsa:2048 -days 1 \
        -keyout "$CERT_PATH/privkey.pem" \
        -out "$CERT_PATH/fullchain.pem" \
        -subj "/CN=localhost" 2>/dev/null
fi

echo "=== [2/4] Nginx 기동 ==="
docker compose -f $COMPOSE_FILE up -d nginx

echo "=== [3/4] Let's Encrypt 정식 SSL 인증서 발급 ==="
rm -rf "$CERT_PATH"
docker run --rm \
    -v $(pwd)/certbot/conf:/etc/letsencrypt \
    -v $(pwd)/certbot/www:/var/www/certbot \
    certbot/certbot certonly --webroot -w /var/www/certbot \
    --email $EMAIL --agree-tos --no-eff-email \
    -d $DOMAIN --force-renewal

echo "=== [4/4] Nginx SSL 적용 및 리로드 ==="
docker compose -f $COMPOSE_FILE exec nginx nginx -s reload

echo "✅ [성공] https://$DOMAIN HTTPS 보안 접속이 활성화되었습니다!"
