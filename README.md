# ndustrial.io Helm Charts

[![CI](https://github.com/ndustrialio/charts/workflows/CI/badge.svg)](https://github.com/ndustrialio/charts/actions?query=workflow%3ACI)

This repository hosts the **[ndustrial.io](https://ndustrial.io) Helm Charts** for deploying to [Kubernetes](https://kubernetes.io/).

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up, add the repo:

```console
helm repo add ndustrial https://ndustrialio.github.io/charts
helm repo update
```

You can then run `helm search repo ndustrial` to see the charts.

## Charts

- [`common`](ndustrial/common/README.md) - common chart which provides helper functions for all charts
- [`cronjob`](ndustrial/cronjob/README.md) - chart to deploy `CronJob` resources
- [`deployment`](ndustrial/deployment/README.md) - chart to deploy `Deployment` resources
- [`statefulset`](ndustrial/statefulset/README.md) - chart to deploy `StatefulSet` resources

## CI/CD

We use GitHub Actions to test and release our charts. On a pull request, our [CI pipeline](./.github/workflows/ci.yaml) will lint and test any changes via Helm's [Chart Testing](https://github.com/helm/chart-testing#readme) tool. On a commit to master, our [Release pipeline](./.github/workflows/release.yaml) will package and release new charts to [GitHub Pages](https://pages.github.com/) via Helm's [Chart Releaser](https://github.com/helm/chart-releaser#readme).

## Development

All charts depend on the ndustrial [`common` chart](ndustrial/common/README.md).

### README Generator

Documentation is generated using [readme-generator-for-helm](https://github.com/bitnami-labs/readme-generator-for-helm) and can be ran via `make gen`.

### Lint Testing

Helm linting is done via Helm's [Chart Testing](https://github.com/helm/chart-testing#readme). This is ran via the CI pipeline but can be ran locally via docker with `make lint`.
