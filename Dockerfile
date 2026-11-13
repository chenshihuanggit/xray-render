FROM alpine:3.20
RUN apk add --no-cache curl unzip tzdata \
 && curl -fsSL -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && mkdir -p /usr/local/bin /usr/local/etc/xray \
 && unzip -o /tmp/xray.zip -d /tmp/xray \
 && cp /tmp/xray/xray /usr/local/bin/xray \
 && cp /tmp/xray/geoip.dat /tmp/xray/geosite.dat /usr/local/bin/ \
 && chmod +x /usr/local/bin/xray \
 && rm -rf /tmp/xray /tmp/xray.zip
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
