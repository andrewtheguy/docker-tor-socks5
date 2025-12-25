# docker-tor-socks5

A simple Tor SOCKS5 proxy Docker image based on Alpine Linux.

Based on [osminogin/docker-tor-simple](https://github.com/osminogin/docker-tor-simple) with some tweaks:
- Uses stable Alpine instead of edge
- Logs to console instead of file
- Uses tini as init wrapper

## Usage

```bash
docker run -d -p 9050:9050 ghcr.io/andrewtheguy/tor-socks5
```

Test the proxy:

```bash
curl -x socks5h://127.0.0.1:9050 https://check.torproject.org/api/ip
```

## Build

Local build:

```bash
./build.sh
```

Or trigger the GitHub Actions workflow manually to build and push multi-arch images (amd64/arm64).
