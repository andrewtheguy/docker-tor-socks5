variable "TAG" {
}


variable "IMAGE_NAME" {
    default="ghcr.io/andrewtheguy/tor-socks5"
}


group "default" {
    targets = ["worker_multi"]
}


target "worker_multi" {
    tags = ["${IMAGE_NAME}:${TAG}","${IMAGE_NAME}:latest"]
    platforms = ["linux/amd64", "linux/arm64"]
}

