# Ndustrial Common Library Chart

A [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm) for grouping common logic between ndustrial charts.

The [Bitnami Common Chart](https://github.com/bitnami/charts/tree/master/bitnami/common) was used as a base for this.

## TL;DR

```yaml
dependencies:
  - name: common
    version: 0.x.x
    repository: https://ndustrialio.github.io/charts
```

```bash
$ helm dependency update
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: { { include "nio-common.names.fullname" . } }
data:
  myvalue: "Hello World"
```

## Introduction

This chart provides a common template helpers which can be used to develop new charts using [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Parameters

### Ndustrial metadata fields (Optional)

| Name                          | Description                                                                                                   | Value |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------- | ----- |
| `ndustrial`                   |                                                                                                               | `{}`  |
| `ndustrial.project`           | Unique project id that this repository belongs too (Required) aka. Project slug                               | `""`  |
| `ndustrial.name`              | The name of the application/service. (Required)                                                               | `""`  |
| `ndustrial.type`              | The service type of this deployment (api, database, backend, frontend, etl, etc...) (Required)                | `""`  |
| `ndustrial.organization`      | The slug of the Organization that owns the application (Required)                                             | `""`  |
| `ndustrial.owner`             | The person/team that owns this service. (Required)                                                            | `""`  |
| `ndustrial.managed_by`        | The service which manages the kubernetes object Should most likely be one of: helm, contxt, fleet. (Required) | `""`  |
| `ndustrial.env`               | The environment being deployed into Should most likely be one of: dev, staging, prod, or qa. (Required)       | `""`  |
| `ndustrial.version`           | The app version being deployed (Required)                                                                     | `""`  |
| `ndustrial.repo`              | The github repository where the code exists (populated by CI/CD)                                              | `""`  |
| `ndustrial.depends`           | List of projects/services this serivce depends on                                                             | `[]`  |
| `ndustrial.depends.0.project` | The name of the project that this service depends on                                                          | `""`  |
| `ndustrial.depends.0.name`    | The name of the project service                                                                               | `""`  |
| `contxt`                      |                                                                                                               | `{}`  |
| `contxt.projectId`            | The ID of the Contxt Stack that this object belongs to (if applicable)                                        | `""`  |
| `contxt.serviceId`            | The ID of the Contxt Service that this object belongs to (if applicable)                                      | `""`  |
| `contxt.serviceType`          | The type of the Contxt Service that this object belongs to (if applicable)                                    | `""`  |


### Datadog integration parameters

| Name                                 | Description                                                                                                                                                                                                         | Value      |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| `datadog.apm.enabled`                | Enable Datadog APM                                                                                                                                                                                                  | `false`    |
| `datadog.apm.agent_host`             | The Datadog Agent hostname for sending traces -- has the same functionality as the below trace_agent_host but is used by different language's implementations of the Datadog trace library (Default: status.hostIP) | `""`       |
| `datadog.apm.env`                    | Set an application’s environment e.g. prod, pre-prod, staging.                                                                                                                                                      | `""`       |
| `datadog.apm.version`                | Set an application’s version in traces and logs e.g. 1.2.3, 6c44da20, 2020.02.13. Generally set along with DD_SERVICE.                                                                                              | `""`       |
| `datadog.apm.profiling_enabled`      | Enable Datadog profiling when using ddtrace-run. (Default: false)                                                                                                                                                   | `false`    |
| `datadog.apm.logs_injection`         | Enables Logs Injection https://ddtrace.readthedocs.io/en/stable/advanced_usage.html#logs-injection (Default: true)                                                                                                  | `true`     |
| `datadog.apm.trace_sample_rate`      | A float, f, 0.0 <= f <= 1.0. f*100% of traces will be sampled. (Default: 1.0)                                                                                                                                       | `1`        |
| `datadog.apm.trace_agent_host`       | The Datadog Agent hostname for sending traces -- has the same functionality as the above agent_host but is used by different language's implementations of the Datadog trace library (Default: status.hostIP)       | `""`       |
| `datadog.openmetrics.enabled`        | Enable OpenMetrics scraping                                                                                                                                                                                         | `false`    |
| `datadog.openmetrics.schema`         | The schema to use for OpenMetrics. (Default: http)                                                                                                                                                                  | `http`     |
| `datadog.openmetrics.host`           | The hostname or ip to scape metrics from. (Default: Pod ip)                                                                                                                                                         | `%%host%%` |
| `datadog.openmetrics.port`           | The port to scrap metrics from (Default: 8080)                                                                                                                                                                      | `8080`     |
| `datadog.openmetrics.endpoint`       | The endpoint to scrape metrics from                                                                                                                                                                                 | `/metrics` |
| `datadog.openmetrics.metrics`        | List of metrics to collect                                                                                                                                                                                          | `[]`       |
| `datadog.openmetrics.type_overrides` | Override the collected metrics types                                                                                                                                                                                | `{}`       |


## Special input schemas

### ImageRoot

```yaml
registry:
  type: string
  description: Docker registry where the image is located
  example: docker.ops.ndustrial.io

repository:
  type: string
  description: Repository and image name
  example: bitnami/nginx

tag:
  type: string
  description: image tag
  example: 1.16.1-debian-10-r63

pullPolicy:
  type: string
  description: Specify a imagePullPolicy. Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'

pullSecrets:
  type: array
  items:
    type: string
  description: Optionally specify an array of imagePullSecrets (evaluated as templates).

debug:
  type: boolean
  description: Set to true if you would like to see extra information on logs
  example: false
## An instance would be:
# registry: docker.ops.ndustrial.io
# repository: bitnami/nginx
# tag: 1.16.1-debian-10-r63
# pullPolicy: IfNotPresent
# debug: false
```

### Persistence

```yaml
enabled:
  type: boolean
  description: Whether enable persistence.
  example: true

storageClass:
  type: string
  description: Ghost data Persistent Volume Storage Class, If set to "-", storageClassName: "" which disables dynamic provisioning.
  example: "-"

accessMode:
  type: string
  description: Access mode for the Persistent Volume Storage.
  example: ReadWriteOnce

size:
  type: string
  description: Size the Persistent Volume Storage.
  example: 8Gi

path:
  type: string
  description: Path to be persisted.
  example: /bitnami

## An instance would be:
# enabled: true
# storageClass: "-"
# accessMode: ReadWriteOnce
# size: 8Gi
# path: /bitnami
```

### ExistingSecret

```yaml
name:
  type: string
  description: Name of the existing secret.
  example: mySecret
keyMapping:
  description: Mapping between the expected key name and the name of the key in the existing secret.
  type: object
## An instance would be:
# name: mySecret
# keyMapping:
#   password: myPasswordKey
```

#### Example of use

When we store sensitive data for a deployment in a secret, some times we want to give to users the possibility of using theirs existing secrets.

```yaml
# templates/secret.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: { { include "nio-common.names.fullname" . } }
  labels:
    app: { { include "nio-common.names.fullname" . } }
type: Opaque
data:
  password: { { .Values.password | b64enc | quote } }

# templates/dpl.yaml
---

---
env:
  - name: PASSWORD
    valueFrom:
      secretKeyRef:
        name:
          {
            {
              include "nio-common.secrets.name" (dict "existingSecret" .Values.existingSecret "context" $),
            },
          }
        key:
          {
            {
              include "nio-common.secrets.key" (dict "existingSecret" .Values.existingSecret "key" "password"),
            },
          }
...
# values.yaml
---
name: mySecret
keyMapping:
  password: myPasswordKey
```

### ValidateValue

#### NOTES.txt

```console
{{- $validateValueConf00 := (dict "valueKey" "path.to.value00" "secret" "secretName" "field" "password-00") -}}
{{- $validateValueConf01 := (dict "valueKey" "path.to.value01" "secret" "secretName" "field" "password-01") -}}

{{ include "nio-common.validations.values.multiple.empty" (dict "required" (list $validateValueConf00 $validateValueConf01) "context" $) }}
```

If we force those values to be empty we will see some alerts

```console
$ helm install test mychart --set path.to.value00="",path.to.value01=""
    'path.to.value00' must not be empty, please add '--set path.to.value00=$PASSWORD_00' to the command. To get the current value:

        export PASSWORD_00=$(kubectl get secret --namespace default secretName -o jsonpath="{.data.password-00}" | base64 --decode)

    'path.to.value01' must not be empty, please add '--set path.to.value01=$PASSWORD_01' to the command. To get the current value:

        export PASSWORD_01=$(kubectl get secret --namespace default secretName -o jsonpath="{.data.password-01}" | base64 --decode)
```
