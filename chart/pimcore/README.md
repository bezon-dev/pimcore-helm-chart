# Pimecore Helm Chart

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2025.1](https://img.shields.io/badge/AppVersion-2025.1-informational?style=flat-square)

A Helm chart to deploy Pimecore on Kubernetes

**Homepage:** <https://github.com/bezon-dev/pimcore-helm-chart>

## Prerequisites

You need a valid product-key, instance-identifier, secret-key combination.

One way to get such a combination is to do a docker based installation as described in the [Pimcore documentation](https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Installation/Docker_Based_Installation) and registering the instance at Pimcore. After a successful installation the needed information are available in the `config/local/product_registration.yaml` file. Then put the values into your `values.yaml` file:

```yaml
php:
  env:
    PIMCORE_INSTALL_INSTANCE_IDENTIFIER: "your-instance-identifier"
  secretEnv:
    PIMCORE_INSTALL_PRODUCT_KEY: "your-product-key"
    PIMCORE_INSTALL_ENCRYPTION_SECRET: "your-encryption-secret"
```

Read more about the product registration in the [Pimcore documentation](https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Product_Registration).

## Installation

```bash
helm repo add pimcore-helm-chart https://bezon-dev.github.io/pimcore-helm-chart
helm repo update
helm install -n <pimcore-namespace> <release-name> pimcore-helm-chart/pimcore -f values.yaml --version 1.0.1
```

## Limitations

Currently the Helm Chart is built to get Pimcore running in a Kubernetes cluster as easy as possible. Just like the [Docker based installation guide](https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Installation/Docker_Based_Installation). It is not meant to be a production ready solution. The following limitations are known:

* No multi replica or horizontal auto scaling support.
* No explicit configuration for file storage setup, should be possible via extra volumes but it is not tested.
* Very simple non high available setups for Mariadb, ValKey (Redis) and RabbitMQ be default. You have to configure them yourself in your `values.yaml` file if you need a production ready setup.
* No support to use external instances of MariaDB, ValKey (Redis) or RabbitMQ.
* No support for Backup & Recocery, you have to implement this by yourself.
* The web root is one persistent volume and includes the whole Pimcore system including the user generated php files.

We will address some of these limitations in the future. If you have any suggestions or feature requests, please open an issue.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Klaus Erber | <k.erber@erber-freelance.de> |  |

## Source Code

* <https://github.com/bezon-dev/pimcore-helm-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | 20.5.5 |
| https://charts.bitnami.com/bitnami | rabbitmq | 16.0.2 |
| https://charts.bitnami.com/bitnami | valkey | 3.0.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | affinity for the pod |
| autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | This section is for setting up autoscaling more information can be found here: https://kubernetes.io/docs/concepts/workloads/autoscaling/ |
| autoscaling.enabled | bool | `false` | This sets the autoscaling enabled or not, multireplica is not supported yet, please leave it as false |
| fullnameOverride | string | `""` | This is to override the chart full name. |
| imagePullSecrets | list | `[]` | This is for the secrets for pulling an image from a private repository more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"annotations":{},"enabled":false,"hosts":[{"host":"host.example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | This block is for setting up the ingress for more information can be found here: https://kubernetes.io/docs/concepts/services-networking/ingress/ |
| ingress.annotations | object | `{}` | This sets the ingress annotations |
| ingress.enabled | bool | `false` | This sets the ingress enabled or not |
| ingress.hosts[0] | object | `{"host":"host.example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}` | This sets the host name for the ingress |
| ingress.tls | list | `[]` | This sets the tls for the ingress |
| mariadb.auth.database | string | `"pimcore"` |  |
| mariadb.auth.password | string | `"pimcore-password"` |  |
| mariadb.auth.rootPassword | string | `"my-root-password"` |  |
| mariadb.auth.username | string | `"pimcore"` |  |
| mariadb.enabled | bool | `true` | This sets the mariadb enabled or not, please refer the mariadb chart to configure the database: https://artifacthub.io/packages/helm/bitnami/mariadb |
| mariadb.initdbScripts."01-charset.sql" | string | `"ALTER DATABASE pimcore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;\n"` |  |
| mariadb.primary.affinity | object | `{}` |  |
| mariadb.primary.resources | object | `{}` |  |
| mariadb.primary.tolerations | list | `[]` |  |
| nameOverride | string | `""` | This is to override the chart name. |
| nginx.image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images. |
| nginx.image.repository | string | `"nginx"` | image repository for the nginx container |
| nginx.image.tag | string | `"1.28.0-alpine"` | Image tag |
| nodeSelector | object | `{}` | nodeSelector for the pod |
| php.env.APP_DEBUG | string | `"false"` | Debug mode, true or false |
| php.env.APP_ENV | string | `"dev"` | Environment to start, one of: dev, test, prod |
| php.env.PIMCORE_INSTALL_ADMIN_USERNAME | string | `"admin"` | The name of the admin user |
| php.env.PIMCORE_INSTALL_INSTANCE_IDENTIFIER | string | `"your-instance-identifier"` | see: https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Product_Registration |
| php.image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images. |
| php.image.repository | string | `"pimcore/pimcore"` | image repository for the pimcore php container |
| php.image.tag | string | `"php8.3.21-debug-v3.6"` | Image tag |
| php.livenessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":10,"periodSeconds":10,"successThreshold":1,"tcpSocket":{"port":9000},"timeoutSeconds":2}` | liveness probe |
| php.readinessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":10,"successThreshold":1,"tcpSocket":{"port":9000},"timeoutSeconds":2}` | readiness probe |
| php.resources | object | `{}` | This sets resources for the php container |
| php.secretEnv.PIMCORE_INSTALL_ADMIN_PASSWORD | string | `"admin"` | The password for the admin user |
| php.secretEnv.PIMCORE_INSTALL_ENCRYPTION_SECRET | string | `"your-encryption-secret"` | see: https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Product_Registration |
| php.secretEnv.PIMCORE_INSTALL_MYSQL_PASSWORD | string | `"pimcore-password"` | The database passeord, must the same as in the mariadb section |
| php.secretEnv.PIMCORE_INSTALL_PRODUCT_KEY | string | `"your-product-key"` | see: https://docs.pimcore.com/platform/next/Pimcore/Getting_Started/Product_Registration |
| php.securityContext.runAsGroup | int | `33` | Group to run the php conatainer, 33=www-data |
| php.securityContext.runAsUser | int | `33` | User to run the php conatainer, 33=www-data |
| php.startupProbe | object | `{"failureThreshold":120,"initialDelaySeconds":5,"periodSeconds":5,"successThreshold":1,"tcpSocket":{"port":9000},"timeoutSeconds":2}` | startup probe |
| php.volumeMounts | list | `[]` | Additional volumeMounts for the Deployment. |
| pimecorePackage | string | `"pimcore/skeleton"` | package to install possible values:<br />   pimcore/skeleton<br />   pimcore/demo |
| podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| podSecurityContext.fsGroup | int | `33` |  |
| preInitApp.image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images. |
| preInitApp.image.repository | string | `"bitnami/mariadb"` | image repository for the init-app container |
| preInitApp.image.tag | string | `"11.4.6-debian-12-r0"` | Image tag |
| pvc.storage | string | `"10Gi"` | Size of the volume for the web root |
| rabbitmq.affinity | object | `{}` |  |
| rabbitmq.auth.erlangCookie | string | `"my-erlang-cookie"` |  |
| rabbitmq.auth.password | string | `"bitnami"` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.enabled | bool | `true` | This sets the rabbitmq enabled or not, please refer the rabbitmq chart to configure this service: https://artifacthub.io/packages/helm/bitnami/rabbitmq |
| rabbitmq.persistence.enabled | bool | `true` |  |
| rabbitmq.persistence.size | string | `"2Gi"` |  |
| rabbitmq.resources | object | `{}` |  |
| rabbitmq.tolerations | list | `[]` |  |
| rabbitmqPassword | string | `"bitnami"` | This is the rabbitmq password, must be the same as in the rabbitmq section |
| rabbitmqUser | string | `"user"` | This is the rabbitmq user, must be the same as in the rabbitmq section |
| replicaCount | int | `1` | Multireplica is not supported yet, please leave it as 1 |
| service | object | `{"port":80,"type":"ClusterIP"}` | This is for setting up a service more information can be found here: https://kubernetes.io/docs/concepts/services-networking/service/ |
| service.port | int | `80` | This sets the ports more information can be found here: https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports |
| service.type | string | `"ClusterIP"` | This sets the service type more information can be found here: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| serviceAccount | object | `{"annotations":{},"automount":true,"create":true,"name":""}` | This section builds out the service account more information can be found here: https://kubernetes.io/docs/concepts/security/service-accounts/ |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| supervisord.image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images. |
| supervisord.image.repository | string | `"pimcore/pimcore"` | image repository for the supervisord container |
| supervisord.image.tag | string | `"php8.3.21-supervisord-v3.6"` | Image tag |
| supervisord.securityContext.runAsGroup | int | `33` | Group to run the supervisord container, 33=www-data |
| supervisord.securityContext.runAsUser | int | `33` | User to run the supervisord container, 33=www-data |
| terminationGracePeriodSeconds | int | `30` | This is the termination grace period for the pod |
| tolerations | list | `[]` | tolerations for the pod |
| valkey.architecture | string | `"standalone"` |  |
| valkey.auth.enabled | bool | `false` |  |
| valkey.enabled | bool | `true` | This sets the valkey enabled or not, please refer the valkey chart to configure this service: https://artifacthub.io/packages/helm/bitnami/valkey |
| valkey.primary.affinity | object | `{}` |  |
| valkey.primary.extraFlags[0] | string | `"--maxmemory 128mb"` |  |
| valkey.primary.extraFlags[1] | string | `"--maxmemory-policy volatile-lru"` |  |
| valkey.primary.extraFlags[2] | string | `"--save \"\""` |  |
| valkey.primary.persistence.enabled | bool | `true` |  |
| valkey.primary.persistence.size | string | `"2Gi"` |  |
| valkey.primary.resources | object | `{}` |  |
| valkey.primary.tolerations | list | `[]` |  |
| volumes | list | `[]` | Additional volumes on the output Deployment definition. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
