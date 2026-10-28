#!/bin/bash
HOST="client-update.steamstatic.com"
CDN="client-update.akamai.steamstatic.com"
HOSTS="/etc/hosts"

IP=$(curl -s "https://cloudflare-dns.com/dns-query?name=$CDN&type=A" -H "Accept: application/dns-json" | grep -oE '"data":"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"' | head -n 1 | cut -d'"' -f4)

if [ -n "$IP" ]; then
    sed -i "/[[:space:]]$HOST$/d" "$HOSTS"
    echo "$IP $HOST" >> "$HOSTS"
    echo "Thành công! Đã cập nhật IP: $IP cho $HOST"
else
    echo "Lỗi: Không lấy được IP qua API!"
    exit 1
fi
