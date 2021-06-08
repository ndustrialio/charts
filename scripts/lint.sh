#!/bin/bash
set -e

docker run --rm -ti -v $(pwd):/app -w /app/ndustrial/ quay.io/helmpack/chart-testing /bin/sh -c "helm repo add ndustrial https://ndustrialio.github.io/charts && ct lint --chart-dirs /app/ndustrial/ --all"
