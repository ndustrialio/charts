#!/bin/bash
set -e

docker run --rm -ti -v $(pwd):/app -w /app/ndustrial/ quay.io/helmpack/chart-testing /bin/sh -c "ct lint --chart-dirs /app/ndustrial/ --all --config /app/ct.yaml"
