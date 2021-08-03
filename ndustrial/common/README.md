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
  name: { { include "common.names.fullname" . } }
data:
  myvalue: "Hello World"
```

## Introduction

This chart provides a common template helpers which can be used to develop new charts using [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0

## Parameters

### Ndustrial metadata fields

| Name                          | Description                                                                                                   | Value |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------- | ----- |
| `ndustrial.project`           | Unique project id that this repository belongs too (Required) aka. Project slug                               | `nil` |
| `ndustrial.name`              | The name of the application/service. (Required)                                                               | `nil` |
| `ndustrial.type`              | The service type of this deployment (api, database, backend, frontend, etl, etc...) (Required)                | `nil` |
| `ndustrial.organization`      | The slug of the Organization that owns the application (Required)                                             | `nil` |
| `ndustrial.owner`             | The person/team that owns this service. (Required)                                                            | `nil` |
| `ndustrial.managed_by`        | The service which manages the kubernetes object Should most likely be one of: helm, contxt, fleet. (Required) | `nil` |
| `ndustrial.env`               | The environment being deployed into Should most likely be one of: dev, staging, prod, or qa. (Required)       | `nil` |
| `ndustrial.version`           | The app version being deployed (Required)                                                                     | `nil` |
| `ndustrial.repo`              | The github repository where the code exists (populated by CI/CD)                                              | `nil` |
| `ndustrial.depends`           | List of projects/services this serivce depends on                                                             | `[]`  |
| `ndustrial.depends.0.project` | The name of the project that this service depends on                                                          | `""`  |
| `ndustrial.depends.0.name`    | The name of the project service                                                                               | `""`  |
| `contxt.projectId`            | The ID of the Contxt Stack that this object belongs to (if applicable)                                        | `nil` |
| `contxt.serviceId`            | The ID of the Contxt Service that this object belongs to (if applicable)                                      | `nil` |
| `contxt.serviceType`          | The type of the Contxt Service that this object belongs to (if applicable)                                    | `nil` |

### Datadog integration parameters

| Name                                 | Description                                                                                                                                                                                                         | Value      |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| `datadog.apm.enabled`                | Enable Datadog APM                                                                                                                                                                                                  | `false`    |
| `datadog.apm.agent_host`             | The Datadog Agent hostname for sending traces -- has the same functionality as the below trace_agent_host but is used by different language's implementations of the Datadog trace library (Default: status.hostIP) | `""`       |
| `datadog.apm.env`                    | Set an application’s environment e.g. prod, pre-prod, staging.                                                                                                                                                      | `""`       |
| `datadog.apm.version`                | Set an application’s version in traces and logs e.g. 1.2.3, 6c44da20, 2020.02.13. Generally set along with DD_SERVICE.                                                                                              | `""`       |
| `datadog.apm.profiling_enabled`      | Enable Datadog profiling when using ddtrace-run. (Default: false)                                                                                                                                                   | `false`    |
| `datadog.apm.logs_injection`         | Enables Logs Injection https://ddtrace.readthedocs.io/en/stable/advanced_usage.html#logs-injection (Default: true)                                                                                                  | `true`     |
| `datadog.apm.trace_sample_rate`      | A float, f, 0.0 <= f <= 1.0. f\*100% of traces will be sampled. (Default: 1.0)                                                                                                                                      | `1`        |
| `datadog.apm.trace_agent_host`       | The Datadog Agent hostname for sending traces -- has the same functionality as the above agent_host but is used by different language's implementations of the Datadog trace library (Default: status.hostIP)       | `""`       |
| `datadog.openmetrics.enabled`        | Enable OpenMetrics scraping                                                                                                                                                                                         | `false`    |
| `datadog.openmetrics.schema`         | The schema to use for OpenMetrics. (Default: http)                                                                                                                                                                  | `http`     |
| `datadog.openmetrics.host`           | The hostname or ip to scape metrics from. (Default: Pod ip)                                                                                                                                                         | `%%host%%` |
| `datadog.openmetrics.port`           | The port to scrap metrics from (Default: 8080)                                                                                                                                                                      | `8080`     |
| `datadog.openmetrics.endpoint`       | The endpoint to scrape metrics from                                                                                                                                                                                 | `/metrics` |
| `datadog.openmetrics.metrics`        | List of metrics to collect                                                                                                                                                                                          | `[]`       |
| `datadog.openmetrics.type_overrides` | Override the collected metrics types                                                                                                                                                                                | `{}`       |

The following table lists the helpers available in the library which are scoped in different sections.

### Affinities

| Helper identifier             | Description                                          | Expected Input                                 |
| ----------------------------- | ---------------------------------------------------- | ---------------------------------------------- |
| `common.affinities.node.soft` | Return a soft nodeAffinity definition                | `dict "key" "FOO" "values" (list "BAR" "BAZ")` |
| `common.affinities.node.hard` | Return a hard nodeAffinity definition                | `dict "key" "FOO" "values" (list "BAR" "BAZ")` |
| `common.affinities.pod.soft`  | Return a soft podAffinity/podAntiAffinity definition | `dict "component" "FOO" "context" $`           |
| `common.affinities.pod.hard`  | Return a hard podAffinity/podAntiAffinity definition | `dict "component" "FOO" "context" $`           |

### Capabilities

| Helper identifier                            | Description                                                                                    | Expected Input    |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------- | ----------------- |
| `common.capabilities.kubeVersion`            | Return the target Kubernetes version (using client default if .Values.kubeVersion is not set). | `.` Chart context |
| `common.capabilities.deployment.apiVersion`  | Return the appropriate apiVersion for deployment.                                              | `.` Chart context |
| `common.capabilities.statefulset.apiVersion` | Return the appropriate apiVersion for statefulset.                                             | `.` Chart context |
| `common.capabilities.ingress.apiVersion`     | Return the appropriate apiVersion for ingress.                                                 | `.` Chart context |
| `common.capabilities.rbac.apiVersion`        | Return the appropriate apiVersion for RBAC resources.                                          | `.` Chart context |
| `common.capabilities.crd.apiVersion`         | Return the appropriate apiVersion for CRDs.                                                    | `.` Chart context |
| `common.capabilities.supportsHelmVersion`    | Returns true if the used Helm version is 3.3+                                                  | `.` Chart context |
| `common.capabilities.cronjob.apiVersion`     | Return the appropriate apiVersion for CronJob resources.                                       | `.` Chart context |

### Errors

| Helper identifier                       | Description                                                                                                                                                            | Expected Input                                                                     |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `common.errors.upgrade.passwords.empty` | It will ensure required passwords are given when we are upgrading a chart. If `validationErrors` is not empty it will throw an error and will stop the upgrade action. | `dict "validationErrors" (list $validationError00 $validationError01) "context" $` |

### Images

| Helper identifier                 | Description                                                                                                    | Expected Input                                                                                          |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `common.images.image`             | Return the proper and full image name                                                                          | `dict "imageRoot" .Values.path.to.the.image "global" $`, see [ImageRoot](#imageroot) for the structure. |
| `common.images.pullSecrets`       | Return the proper Docker Image Registry Secret Names (deprecated: use common.images.renderPullSecrets instead) | `dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "global" .Values.global`   |
| `common.images.renderPullSecrets` | Return the proper Docker Image Registry Secret Names (evaluates values as templates)                           | `dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "context" $`               |

### Ingress

| Helper identifier        | Description                                                          | Expected Input                                                                                                                                                                   |
| ------------------------ | -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `common.ingress.backend` | Generate a proper Ingress backend entry depending on the API version | `dict "serviceName" "foo" "servicePort" "bar"`, see the [Ingress deprecation notice](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/) for the syntax differences |

### Labels

| Helper identifier           | Description                                          | Expected Input    |
| --------------------------- | ---------------------------------------------------- | ----------------- |
| `common.labels.standard`    | Return Kubernetes standard labels                    | `.` Chart context |
| `common.labels.matchLabels` | Return the proper Docker Image Registry Secret Names | `.` Chart context |

### Names

| Helper identifier       | Description                                                | Expected Inpput   |
| ----------------------- | ---------------------------------------------------------- | ----------------- |
| `common.names.name`     | Expand the name of the chart or use `.Values.nameOverride` | `.` Chart context |
| `common.names.fullname` | Create a default fully qualified app name.                 | `.` Chart context |
| `common.names.chart`    | Chart name plus version                                    | `.` Chart context |

### Secrets

| Helper identifier         | Description                                                  | Expected Input                                                                                                                                                                                                                  |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `common.secrets.name`     | Generate the name of the secret.                             | `dict "existingSecret" .Values.path.to.the.existingSecret "defaultNameSuffix" "mySuffix" "context" $` see [ExistingSecret](#existingsecret) for the structure.                                                                  |
| `common.secrets.key`      | Generate secret key.                                         | `dict "existingSecret" .Values.path.to.the.existingSecret "key" "keyName"` see [ExistingSecret](#existingsecret) for the structure.                                                                                             |
| `common.passwords.manage` | Generate secret password or retrieve one if already created. | `dict "secret" "secret-name" "key" "keyName" "providedValues" (list "path.to.password1" "path.to.password2") "length" 10 "strong" false "chartName" "chartName" "context" $`, length, strong and chartNAme fields are optional. |
| `common.secrets.exists`   | Returns whether a previous generated secret already exists.  | `dict "secret" "secret-name" "context" $`                                                                                                                                                                                       |

### Storage

| Helper identifier             | Description                           | Expected Input                                                                                                      |
| ----------------------------- | ------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `common.affinities.node.soft` | Return a soft nodeAffinity definition | `dict "persistence" .Values.path.to.the.persistence "global" $`, see [Persistence](#persistence) for the structure. |

### TplValues

| Helper identifier         | Description                            | Expected Input                                                                                                                                           |
| ------------------------- | -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `common.tplvalues.render` | Renders a value that contains template | `dict "value" .Values.path.to.the.Value "context" $`, value is the value should rendered as template, context frequently is the chart context `$` or `.` |

### Utils

| Helper identifier              | Description                                                                              | Expected Input                                                         |
| ------------------------------ | ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| `common.utils.fieldToEnvVar`   | Build environment variable name given a field.                                           | `dict "field" "my-password"`                                           |
| `common.utils.secret.getvalue` | Print instructions to get a secret value.                                                | `dict "secret" "secret-name" "field" "secret-value-field" "context" $` |
| `common.utils.getValueFromKey` | Gets a value from `.Values` object given its key path                                    | `dict "key" "path.to.key" "context" $`                                 |
| `common.utils.getKeyFromList`  | Returns first `.Values` key with a defined value or first of the list if all non-defined | `dict "keys" (list "path.to.key1" "path.to.key2") "context" $`         |

### Validations

| Helper identifier                                | Description                                                                                                                   | Expected Input                                                                                                                                                                                                                                                           |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `common.validations.values.single.empty`         | Validate a value must not be empty.                                                                                           | `dict "valueKey" "path.to.value" "secret" "secret.name" "field" "my-password" "subchart" "subchart" "context" $` secret, field and subchart are optional. In case they are given, the helper will generate a how to get instruction. See [ValidateValue](#validatevalue) |
| `common.validations.values.multiple.empty`       | Validate a multiple values must not be empty. It returns a shared error for all the values.                                   | `dict "required" (list $validateValueConf00 $validateValueConf01) "context" $`. See [ValidateValue](#validatevalue)                                                                                                                                                      |
| `common.validations.values.mariadb.passwords`    | This helper will ensure required password for MariaDB are not empty. It returns a shared error for all the values.            | `dict "secret" "mariadb-secret" "subchart" "true" "context" $` subchart field is optional and could be true or false it depends on where you will use mariadb chart and the helper.                                                                                      |
| `common.validations.values.postgresql.passwords` | This helper will ensure required password for PostgreSQL are not empty. It returns a shared error for all the values.         | `dict "secret" "postgresql-secret" "subchart" "true" "context" $` subchart field is optional and could be true or false it depends on where you will use postgresql chart and the helper.                                                                                |
| `common.validations.values.redis.passwords`      | This helper will ensure required password for Redis<sup>TM</sup> are not empty. It returns a shared error for all the values. | `dict "secret" "redis-secret" "subchart" "true" "context" $` subchart field is optional and could be true or false it depends on where you will use redis chart and the helper.                                                                                          |
| `common.validations.values.cassandra.passwords`  | This helper will ensure required password for Cassandra are not empty. It returns a shared error for all the values.          | `dict "secret" "cassandra-secret" "subchart" "true" "context" $` subchart field is optional and could be true or false it depends on where you will use cassandra chart and the helper.                                                                                  |
| `common.validations.values.mongodb.passwords`    | This helper will ensure required password for MongoDB&reg; are not empty. It returns a shared error for all the values.       | `dict "secret" "mongodb-secret" "subchart" "true" "context" $` subchart field is optional and could be true or false it depends on where you will use mongodb chart and the helper.                                                                                      |

### Warnings

| Helper identifier            | Description                      | Expected Input                                             |
| ---------------------------- | -------------------------------- | ---------------------------------------------------------- |
| `common.warnings.rollingTag` | Warning about using rolling tag. | `ImageRoot` see [ImageRoot](#imageroot) for the structure. |

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
  name: { { include "common.names.fullname" . } }
  labels:
    app: { { include "common.names.fullname" . } }
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
              include "common.secrets.name" (dict "existingSecret" .Values.existingSecret "context" $),
            },
          }
        key:
          {
            {
              include "common.secrets.key" (dict "existingSecret" .Values.existingSecret "key" "password"),
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

{{ include "common.validations.values.multiple.empty" (dict "required" (list $validateValueConf00 $validateValueConf01) "context" $) }}
```

If we force those values to be empty we will see some alerts

```console
$ helm install test mychart --set path.to.value00="",path.to.value01=""
    'path.to.value00' must not be empty, please add '--set path.to.value00=$PASSWORD_00' to the command. To get the current value:

        export PASSWORD_00=$(kubectl get secret --namespace default secretName -o jsonpath="{.data.password-00}" | base64 --decode)

    'path.to.value01' must not be empty, please add '--set path.to.value01=$PASSWORD_01' to the command. To get the current value:

        export PASSWORD_01=$(kubectl get secret --namespace default secretName -o jsonpath="{.data.password-01}" | base64 --decode)
```
