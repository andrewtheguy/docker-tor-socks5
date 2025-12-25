# docker-tor-socks5

A simple Tor SOCKS5 proxy Docker image based on Alpine Linux.

Based on [osminogin/docker-tor-simple](https://github.com/osminogin/docker-tor-simple) with some tweaks:
- Uses stable Alpine instead of edge
- Uses tini as init wrapper
- Adds additional volume `/etc/tor` for custom configuration

## Port

- `9050` - SOCKSv5 proxy (without auth)

## Volumes

- `/etc/tor` - Tor configuration
- `/var/lib/tor` - Data directory (hidden service keys, etc.)

## Usage

```bash
docker run -d -p 127.0.0.1:9050:9050 ghcr.io/andrewtheguy/tor-socks5
```

Test the proxy:

```bash
curl -x socks5h://127.0.0.1:9050 https://check.torproject.org/api/ip
```

**Warning: Don't bind the SOCKSv5 port 9050 to public network addresses unless you know exactly what you are doing. Always bind to `127.0.0.1` as shown above.**

## Custom Configuration

You can mount a custom `torrc` file to modify Tor's behavior:

```bash
docker run -d -p 127.0.0.1:9050:9050 \
  -v ./torrc:/etc/tor/torrc:ro \
  ghcr.io/andrewtheguy/tor-socks5
```

Or copy the default config from the container and modify it:

```bash
docker run --rm ghcr.io/andrewtheguy/tor-socks5 cat /etc/tor/torrc > torrc
```

## Examples

### Hidden Service

Create a `torrc` file:

```
SocksPort 0
Log notice stdout
DataDirectory /var/lib/tor

HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 nginx:80
```

Create a `docker-compose.yml`:

```yaml
services:
  tor:
    image: ghcr.io/andrewtheguy/tor-socks5
    restart: always
    depends_on:
      - nginx
    volumes:
      - ./torrc:/etc/tor/torrc:ro
      - tor-data:/var/lib/tor

  nginx:
    image: nginx
    restart: always

volumes:
  tor-data:
```

Start the services:

```bash
docker compose up -d
```

Get your `.onion` address:

```bash
docker compose exec tor cat /var/lib/tor/hidden_service/hostname
```

## Build

Local build:

```bash
./build.sh
```

Or trigger the GitHub Actions workflow manually to build and push multi-arch images (amd64/arm64).
