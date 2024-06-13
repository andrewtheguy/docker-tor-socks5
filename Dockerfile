# https://github.com/osminogin/docker-tor-simple/blob/master/Dockerfile
FROM alpine:3.20

RUN apk add --no-cache curl tor 

COPY torrc /etc/tor/torrc

EXPOSE 9050

HEALTHCHECK --interval=60s --timeout=15s --start-period=20s \
    CMD curl -x socks5h://127.0.0.1:9050 'https://check.torproject.org/api/ip' | grep -qm1 -E '"IsTor"\s*:\s*true'

VOLUME ["/var/lib/tor"]

USER tor

CMD ["tor"]