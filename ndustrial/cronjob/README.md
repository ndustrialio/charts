## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `nil` |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `nil` |


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


### Common parameters

| Name               | Description                                        | Value |
| ------------------ | -------------------------------------------------- | ----- |
| `nameOverride`     | String to partially override common.names.fullname | `nil` |
| `fullnameOverride` | String to fully override common.names.fullname     | `nil` |
| `labels`           | Labels to add to all deployed objects              | `{}`  |
| `annotations`      | Annotations to add to all deployed objects         | `{}`  |


### CronJob parameters

| Name                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Value       |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `schedule`                   | String to set cronjob's schedule                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `0 0 * * *` |
| `concurrencyPolicy`          | Specifies how to treat concurrent executions of a Job. Valid values are: - "Allow" (default): allows CronJobs to run concurrently; - "Forbid": forbids concurrent runs, skipping next run if previous run hasn't finished yet; - "Replace": cancels currently running job and replaces it with a new one                                                                                                                                                                                                                                                                  | `Forbid`    |
| `failedJobsHistoryLimit`     | The number of failed finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 1.                                                                                                                                                                                                                                                                                                                                                                                                                                    | `1`         |
| `successfulJobsHistoryLimit` | The number of successful finished jobs to retain. This is a pointer to distinguish between explicit zero and not specified. Defaults to 3.                                                                                                                                                                                                                                                                                                                                                                                                                                | `3`         |
| `startingDeadlineSeconds`    | Optional deadline in seconds for starting the job if it misses scheduled time for any reason. Missed jobs executions will be counted as failed ones.                                                                                                                                                                                                                                                                                                                                                                                                                      | `nil`       |
| `activeDeadlineSeconds`      | Specifies the duration in seconds relative to the startTime that the job may be active before the system tries to terminate it; value must be positive integer                                                                                                                                                                                                                                                                                                                                                                                                            | `nil`       |
| `backoffLimit`               | Specifies the number of retries before marking this job failed. Defaults to 6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | `6`         |
| `completions`                | Specifies the desired number of successfully finished pods the job should be run with. Setting to nil means that the success of any pod signals the success of all pods, and allows parallelism to have any positive value. Setting to 1 means that parallelism is limited to 1 and the success of that pod signals the success of the  More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/                                                                                                                                      | `nil`       |
| `parallelism`                | Specifies the maximum desired number of pods the job should run at any given time. The actual number of pods running in steady state will be less than this number when ((.spec.completions - .status.successful) < .spec.parallelism), i.e. when the work left to do is less than max parallelism. More info: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/                                                                                                                                                                          | `nil`       |
| `ttlSecondsAfterFinished`    | Limits the lifetime of a Job that has finished execution (either Complete or Failed). If this field is set, ttlSecondsAfterFinished after the Job finishes, it is eligible to be automatically deleted. When the Job is being deleted, its lifecycle guarantees (e.g. finalizers) will be honored. If this field is unset, the Job won't be automatically deleted. If this field is set to zero, the Job becomes eligible to be deleted immediately after it finishes. This field is alpha-level and is only honored by servers that enable the TTLAfterFinished feature. | `nil`       |


### Pod Image parameters

| Name                | Description                                          | Value          |
| ------------------- | ---------------------------------------------------- | -------------- |
| `image.registry`    | Deployment image registry                            | `docker.io`    |
| `image.repository`  | Deployment image repository                          | `busybox`      |
| `image.tag`         | Deployment image tag (immutabe tags are recommended) | `latest`       |
| `image.pullPolicy`  | Deployment image pull policy                         | `IfNotPresent` |
| `image.pullSecrets` | Deployment image pull secrets                        | `[]`           |


### Pod parameters

| Name                           | Description                                                                                                                                                                                                                                                                                                                                 | Value           |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `command`                      | Override CronJob default command                                                                                                                                                                                                                                                                                                            | `[]`            |
| `args`                         | Override CronJob default args                                                                                                                                                                                                                                                                                                               | `[]`            |
| `priorityClassName`            | CronJob pod priority class name                                                                                                                                                                                                                                                                                                             | `nil`           |
| `hostAliases`                  | Custom host aliases for CronJob pods                                                                                                                                                                                                                                                                                                        | `[]`            |
| `tolerations`                  | Tolerations for pod assignment                                                                                                                                                                                                                                                                                                              | `[]`            |
| `podLabels`                    | Extra labels for CronJob pods                                                                                                                                                                                                                                                                                                               | `{}`            |
| `podAnnotations`               | Annotations for CronJob pods                                                                                                                                                                                                                                                                                                                | `{}`            |
| `lifecycleHooks`               | Add lifecycle hooks to the CronJob deployment                                                                                                                                                                                                                                                                                               | `{}`            |
| `updateStrategy.type`          | CronJob deployment update strategy                                                                                                                                                                                                                                                                                                          | `RollingUpdate` |
| `updateStrategy.rollingUpdate` | CronJob deployment rolling update configuration parameters                                                                                                                                                                                                                                                                                  | `{}`            |
| `shareProcessNamespace`        | Share a single process namespace between all of the containers in a pod. When this is set containers will be able to view and signal processes from other containers in the same pod, and the first process in each container will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both be set. Optional: Default to false. | `false`         |
| `extraEnvVars`                 | Add extra environment variables to the CronJob container                                                                                                                                                                                                                                                                                    | `[]`            |
| `extraEnvVarsCM`               | Name of existing ConfigMap containing extra env vars                                                                                                                                                                                                                                                                                        | `nil`           |
| `extraEnvVarsCMs`              | Optionally specify extra list of additional existing ConfigMaps containing extra env vars                                                                                                                                                                                                                                                   | `[]`            |
| `extraEnvVarsSecret`           | Name of existing Secret containing extra env vars                                                                                                                                                                                                                                                                                           | `nil`           |
| `extraEnvVarsSecrets`          | Optionally specify extra list of additional existing Secrets containing extra env vars                                                                                                                                                                                                                                                      | `[]`            |
| `extraVolumes`                 | Optionally specify extra list of additional volumes for CronJob pods                                                                                                                                                                                                                                                                        | `[]`            |
| `extraVolumeMounts`            | Optionally specify extra list of additional volumeMounts for CronJob container(s)                                                                                                                                                                                                                                                           | `[]`            |
| `initContainers`               | Add additional init containers to the CronJob pods                                                                                                                                                                                                                                                                                          | `{}`            |
| `sidecars`                     | Add additional sidecar containers to the CronJob pod                                                                                                                                                                                                                                                                                        | `{}`            |
| `serviceAccount.create`        | Specifies whether a ServiceAccount should be created                                                                                                                                                                                                                                                                                        | `true`          |
| `serviceAccount.name`          | The name of the ServiceAccount to use.                                                                                                                                                                                                                                                                                                      | `""`            |
| `serviceAccount.annotations`   | Additional custom annotations for the ServiceAccount                                                                                                                                                                                                                                                                                        | `{}`            |
| `resources.limits`             | The resources limits for the CronJob container                                                                                                                                                                                                                                                                                              | `{}`            |
| `resources.requests`           | The requested resources for the CronJob container                                                                                                                                                                                                                                                                                           | `{}`            |


### Pod Security parameters

| Name                                    | Description                                           | Value   |
| --------------------------------------- | ----------------------------------------------------- | ------- |
| `podSecurityContext.enabled`            | Enabled CronJob pods' Security Context                | `false` |
| `podSecurityContext.fsGroup`            | Set CronJob pod's Security Context fsGroup            | `1001`  |
| `containerSecurityContext.enabled`      | Enabled CronJob containers' Security Context          | `false` |
| `containerSecurityContext.runAsUser`    | Set CronJob container's Security Context runAsUser    | `1001`  |
| `containerSecurityContext.runAsNonRoot` | Set CronJob container's Security Context runAsNonRoot | `true`  |


### Pod Affinity parameters

| Name                        | Description                                                                               | Value  |
| --------------------------- | ----------------------------------------------------------------------------------------- | ------ |
| `podAffinityPreset`         | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`   |
| `podAntiAffinityPreset`     | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft` |
| `nodeAffinityPreset.type`   | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`   |
| `nodeAffinityPreset.key`    | Node label key to match. Ignored if `affinity` is set                                     | `""`   |
| `nodeAffinityPreset.values` | Node label values to match. Ignored if `affinity` is set                                  | `[]`   |
| `affinity`                  | Affinity for Cert Manager CronJob                                                         | `{}`   |
| `nodeSelector`              | Node labels for pod assignment                                                            | `{}`   |


### External secrets

| Name                          | Description                                                                           | Value |
| ----------------------------- | ------------------------------------------------------------------------------------- | ----- |
| `externalSecrets`             | Secrets resolved from an external source                                              | `[]`  |
| `externalSecrets.0.path`      | Path of the external secret                                                           | `""`  |
| `externalSecrets.0.secret`    | Optionally specify the name of the generated secret. Default value derived from path  | `""`  |
| `externalSecrets.0.provider`  | Optionally specify the name of the secret store provider. Defaults to "vault-backend" | `""`  |
| `externalSecrets.0.storeKind` | Optionally specify the kind of secret store. Defaults to "ClusterSecretStore"         | `""`  |


