#!/bin/bash
TAG=$(date -u '+%Y%m%d%H%M%S') docker buildx bake -f docker-bake.hcl --push