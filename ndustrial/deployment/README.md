## Parameters

### Global parameters

| Name                          | Description                                                                                                   | Value |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------- | ----- |
| `global.imageRegistry`        | Global Docker image registry                                                                                  | `nil` |
| `global.imagePullSecrets`     | Global Docker registry secret names as an array                                                               | `[]`  |
| `global.storageClass`         | Global StorageClass for Persistent Volume(s)                                                                  | `nil` |
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


### Common parameters

| Name               | Description                                        | Value |
| ------------------ | -------------------------------------------------- | ----- |
| `nameOverride`     | String to partially override common.names.fullname | `nil` |
| `fullnameOverride` | String to fully override common.names.fullname     | `nil` |
| `labels`           | Labels to add to all deployed objects              | `{}`  |
| `annotations`      | Annotations to add to all deployed objects         | `{}`  |


### Deployment parameters

| Name                                 | Description                                                   | Value           |
| ------------------------------------ | ------------------------------------------------------------- | --------------- |
| `replicaCount`                       | Number of Controller replicas                                 | `1`             |
| `startupProbe.enabled`               | Enable startupProbe                                           | `false`         |
| `startupProbe.path`                  | Path for startupProbe                                         | `/`             |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe                        | `60`            |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe                               | `10`            |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe                              | `1`             |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe                            | `3`             |
| `startupProbe.successThreshold`      | Success threshold for startupProbe                            | `1`             |
| `livenessProbe.enabled`              | Enable livenessProbe                                          | `true`          |
| `livenessProbe.path`                 | Path for livenessProbe                                        | `/`             |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe                       | `60`            |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe                              | `10`            |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                             | `1`             |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe                           | `3`             |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe                           | `1`             |
| `readinessProbe.enabled`             | Enable readinessProbe                                         | `true`          |
| `readinessProbe.path`                | Path for readinessProbe                                       | `/`             |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe                      | `5`             |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe                             | `5`             |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                            | `1`             |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe                          | `3`             |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe                          | `1`             |
| `updateStrategy.type`                | Deployment deployment update strategy                         | `RollingUpdate` |
| `updateStrategy.rollingUpdate`       | Deployment deployment rolling update configuration parameters | `{}`            |


### Service parameters

| Name                               | Description                                          | Value       |
| ---------------------------------- | ---------------------------------------------------- | ----------- |
| `service.type`                     | Deployment service type                              | `ClusterIP` |
| `service.port`                     | Deployment service HTTP port                         | `80`        |
| `service.httpsPort`                | Deployment service HTTPS port                        | `nil`       |
| `service.nodePorts.http`           | Node port for HTTP                                   | `nil`       |
| `service.nodePorts.https`          | Node port for HTTPS                                  | `nil`       |
| `service.clusterIP`                | Deployment service Cluster IP                        | `nil`       |
| `service.loadBalancerIP`           | Deployment service Load Balancer IP                  | `nil`       |
| `service.loadBalancerSourceRanges` | Deployment service Load Balancer sources             | `[]`        |
| `service.externalTrafficPolicy`    | Deployment service external traffic policy           | `Cluster`   |
| `service.annotations`              | Additional custom annotations for Deployment service | `{}`        |


### Ingress parameters

| Name                  | Description                                                                                           | Value                    |
| --------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------ |
| `ingress.enabled`     | Enable ingress record generation for Deployment                                                       | `false`                  |
| `ingress.pathType`    | Ingress path type                                                                                     | `ImplementationSpecific` |
| `ingress.apiVersion`  | Force Ingress API version (automatically detected if not set)                                         | `nil`                    |
| `ingress.hostname`    | Default host for the ingress record                                                                   | `chart-example.local`    |
| `ingress.path`        | Default path for the ingress record                                                                   | `ImplementationSpecific` |
| `ingress.annotations` | Additional custom annotations for the ingress record                                                  | `{}`                     |
| `ingress.tls`         | Enable TLS configuration for the host defined at `ingress.hostname` parameter                         | `false`                  |
| `ingress.certManager` | Add the corresponding annotations for cert-manager integration                                        | `false`                  |
| `ingress.selfSigned`  | Create a TLS secret for this ingress record using self-signed certificates generated by Helm          | `false`                  |
| `ingress.extraHosts`  | An array with additional hostname(s) to be covered with the ingress record                            | `[]`                     |
| `ingress.extraPaths`  | An array with additional arbitrary paths that may need to be added to the ingress under the main host | `[]`                     |
| `ingress.extraTls`    | TLS configuration for additional hostname(s) to be covered with this ingress record                   | `[]`                     |
| `ingress.secrets`     | Custom TLS certificates as secrets                                                                    | `[]`                     |


### Autoscaling parameters

| Name                                            | Description | Value   |
| ----------------------------------------------- | ----------- | ------- |
| `autoscaling.enabled`                           |             | `false` |
| `autoscaling.minReplicas`                       |             | `1`     |
| `autoscaling.maxReplicas`                       |             | `10`    |
| `autoscaling.targetCPUUtilizationPercentage`    |             | `80`    |
| `autoscaling.targetMemoryUtilizationPercentage` |             | `80`    |


### Pod Image parameters

| Name                | Description                                          | Value          |
| ------------------- | ---------------------------------------------------- | -------------- |
| `image.registry`    | Deployment image registry                            | `docker.io`    |
| `image.repository`  | Deployment image repository                          | `busybox`      |
| `image.tag`         | Deployment image tag (immutabe tags are recommended) | `latest`       |
| `image.pullPolicy`  | Deployment image pull policy                         | `IfNotPresent` |
| `image.pullSecrets` | Deployment image pull secrets                        | `[]`           |


### Pod parameters

| Name                                    | Description                                                                                                                                                                                                                                                                                                                                 | Value   |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `ports[0].containerPort`                | Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536.                                                                                                                                                                                                                                          | `80`    |
| `ports[0].name`                         | If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services.                                                                                                                                                             | `http`  |
| `ports[0].hostIp`                       | What host IP to bind the external port to.                                                                                                                                                                                                                                                                                                  | `nil`   |
| `ports[0].hostPort`                     | Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this.                                                                                                                                          | `nil`   |
| `ports[0].protocol`                     | Protocol for port. Must be UDP, TCP, or SCTP. Defaults to "TCP".                                                                                                                                                                                                                                                                            | `TCP`   |
| `command`                               | Override Deployment default command                                                                                                                                                                                                                                                                                                         | `[]`    |
| `args`                                  | Override Deployment default args                                                                                                                                                                                                                                                                                                            | `[]`    |
| `priorityClassName`                     | Deployment pod priority class name                                                                                                                                                                                                                                                                                                          | `nil`   |
| `hostAliases`                           | Custom host aliases for Deployment pods                                                                                                                                                                                                                                                                                                     | `[]`    |
| `tolerations`                           | Tolerations for pod assignment                                                                                                                                                                                                                                                                                                              | `[]`    |
| `podLabels`                             | Extra labels for Deployment pods                                                                                                                                                                                                                                                                                                            | `{}`    |
| `podAnnotations`                        | Annotations for Deployment pods                                                                                                                                                                                                                                                                                                             | `{}`    |
| `lifecycleHooks`                        | Add lifecycle hooks to the Deployment deployment                                                                                                                                                                                                                                                                                            | `{}`    |
| `shareProcessNamespace`                 | Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. | `false` |
| `extraEnvVars`                          | Add extra environment variables to the Deployment container                                                                                                                                                                                                                                                                                 | `[]`    |
| `extraEnvVarsCM`                        | Name of existing ConfigMap containing extra env vars                                                                                                                                                                                                                                                                                        | `nil`   |
| `extraEnvVarsSecret`                    | Name of existing Secret containing extra env vars                                                                                                                                                                                                                                                                                           | `nil`   |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for Deployment pods                                                                                                                                                                                                                                                                     | `[]`    |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for Deployment container(s)                                                                                                                                                                                                                                                        | `[]`    |
| `initContainers`                        | Add additional init containers to the Deployment pods                                                                                                                                                                                                                                                                                       | `{}`    |
| `sidecars`                              | Add additional sidecar containers to the Deployment pod                                                                                                                                                                                                                                                                                     | `{}`    |
| `serviceAccount.create`                 | Specifies whether a ServiceAccount should be created                                                                                                                                                                                                                                                                                        | `true`  |
| `serviceAccount.name`                   | The name of the ServiceAccount to use.                                                                                                                                                                                                                                                                                                      | `""`    |
| `serviceAccount.annotations`            | Additional custom annotations for the ServiceAccount                                                                                                                                                                                                                                                                                        | `{}`    |
| `resources.limits`                      | The resources limits for the Deployment container                                                                                                                                                                                                                                                                                           | `{}`    |
| `resources.requests`                    | The requested resources for the Deployment container                                                                                                                                                                                                                                                                                        | `{}`    |
| `podSecurityContext.enabled`            | Enabled Deployment pods' Security Context                                                                                                                                                                                                                                                                                                   | `false` |
| `podSecurityContext.fsGroup`            | Set Deployment pod's Security Context fsGroup                                                                                                                                                                                                                                                                                               | `1000`  |
| `containerSecurityContext.enabled`      | Enabled Deployment containers' Security Context                                                                                                                                                                                                                                                                                             | `false` |
| `containerSecurityContext.runAsUser`    | Set Deployment container's Security Context runAsUser                                                                                                                                                                                                                                                                                       | `1001`  |
| `containerSecurityContext.runAsNonRoot` | Set Deployment container's Security Context runAsNonRoot                                                                                                                                                                                                                                                                                    | `true`  |


### Pod Affinity parameters

| Name                                 | Description                                                                                                                                                                                                                                                                                 | Value   |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `podAffinityPreset`                  | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                         | `""`    |
| `podAntiAffinityPreset`              | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                    | `soft`  |
| `nodeAffinityPreset.type`            | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                                                                                                                                   | `""`    |
| `nodeAffinityPreset.key`             | Node label key to match. Ignored if `affinity` is set                                                                                                                                                                                                                                       | `""`    |
| `nodeAffinityPreset.values`          | Node label values to match. Ignored if `affinity` is set                                                                                                                                                                                                                                    | `[]`    |
| `affinity`                           | Affinity for Cert Manager Deployment                                                                                                                                                                                                                                                        | `{}`    |
| `nodeSelector`                       | Node labels for pod assignment                                                                                                                                                                                                                                                              | `{}`    |
| `podDisruptionBudget.enabled`        | Enable a pod disruption budget                                                                                                                                                                                                                                                              | `false` |
| `podDisruptionBudget.minAvailable`   | An eviction is allowed if at least "minAvailable" pods selected by "selector" will still be available after the eviction, i.e. even in the absence of the evicted pod. So for example you can prevent all voluntary evictions by specifying "100%".                                         | `nil`   |
| `podDisruptionBudget.maxUnavailable` | An eviction is allowed if at most "maxUnavailable" pods selected by "selector" are unavailable after the eviction, i.e. even in absence of the evicted pod. For example, one can prevent all voluntary evictions by specifying 0. This is a mutually exclusive setting with "minAvailable". | `nil`   |


### Metrics paramaters

| Name                                      | Description                                                                                      | Value   |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------ | ------- |
| `metrics.enabled`                         | Start a sidecar prometheus exporter to expose Deployment metrics                                 | `false` |
| `metrics.serviceMonitor.enabled`          | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator                  | `false` |
| `metrics.serviceMonitor.namespace`        | The namespace in which the ServiceMonitor will be created                                        | `nil`   |
| `metrics.serviceMonitor.interval`         | The interval at which metrics should be scraped                                                  | `30s`   |
| `metrics.serviceMonitor.scrapeTimeout`    | The timeout after which the scrape is ended                                                      | `nil`   |
| `metrics.serviceMonitor.relabellings`     | Metrics relabellings to add to the scrape endpoint                                               | `[]`    |
| `metrics.serviceMonitor.honorLabels`      | Specify honorLabels parameter to add the scrape endpoint                                         | `false` |
| `metrics.serviceMonitor.additionalLabels` | Additional labels that can be used so ServiceMonitor resource(s) can be discovered by Prometheus | `{}`    |


### Datadog integration parameters

| Name                                 | Description                                                 | Value      |
| ------------------------------------ | ----------------------------------------------------------- | ---------- |
| `datadog.apm.enabled`                | Enable Datadog APM                                          | `false`    |
| `datadog.openmetrics.enabled`        | Enable OpenMetrics scraping                                 | `false`    |
| `datadog.openmetrics.schema`         | The schema to use for OpenMetrics. (Default: http)          | `http`     |
| `datadog.openmetrics.host`           | The hostname or ip to scape metrics from. (Default: Pod ip) | `%%host%%` |
| `datadog.openmetrics.port`           | The port to scrap metrics from (Default: 8080)              | `8080`     |
| `datadog.openmetrics.endpoint`       | The endpoint to scrape metrics from                         | `/metrics` |
| `datadog.openmetrics.metrics`        | List of metrics to collect                                  | `[]`       |
| `datadog.openmetrics.type_overrides` | Override the collected metrics types                        | `{}`       |


