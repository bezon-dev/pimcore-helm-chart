#!/usr/bin/env sh

docker run -v $(pwd):/helm-docs jnorwood/helm-docs:v1.14.2
