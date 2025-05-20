# Pimecore Helm Chart

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2025.1](https://img.shields.io/badge/AppVersion-2025.1-informational?style=flat-square)

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
helm repo add pimcore-helm-chart https://pimcore.github.io/pimcore-helm-chart
helm repo update
helm install -n <pimcore-namespace> <release-name> pimcore-helm-chart/pimcore -f values.yaml
```

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
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"host.example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| initApp.image.pullPolicy | string | `"IfNotPresent"` |  |
| initApp.image.repository | string | `"bitnami/mariadb"` |  |
| initApp.image.tag | string | `"11.4.6-debian-12-r0"` |  |
| mariadb.auth.database | string | `"pimcore"` |  |
| mariadb.auth.password | string | `"pimcore-password"` |  |
| mariadb.auth.rootPassword | string | `"my-root-password"` |  |
| mariadb.auth.username | string | `"pimcore"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.initdbScripts."01-charset.sql" | string | `"ALTER DATABASE pimcore CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci;\n"` |  |
| mariadb.primary.affinity | object | `{}` |  |
| mariadb.primary.resources | object | `{}` |  |
| mariadb.primary.tolerations | list | `[]` |  |
| nameOverride | string | `""` |  |
| nginx.image.pullPolicy | string | `"IfNotPresent"` |  |
| nginx.image.repository | string | `"nginx"` |  |
| nginx.image.tag | string | `"1.28.0-alpine"` |  |
| nodeSelector | object | `{}` |  |
| php.args[0] | string | `"/startup.sh"` |  |
| php.env.APP_DEBUG | string | `"false"` |  |
| php.env.APP_ENV | string | `"dev"` |  |
| php.env.PIMCORE_INSTALL_ADMIN_USERNAME | string | `"admin"` |  |
| php.env.PIMCORE_INSTALL_INSTANCE_IDENTIFIER | string | `"your-instance-identifier"` |  |
| php.image.pullPolicy | string | `"IfNotPresent"` |  |
| php.image.repository | string | `"pimcore/pimcore"` |  |
| php.image.tag | string | `"php8.3.21-debug-v3.6"` |  |
| php.livenessProbe.failureThreshold | int | `3` |  |
| php.livenessProbe.initialDelaySeconds | int | `10` |  |
| php.livenessProbe.periodSeconds | int | `10` |  |
| php.livenessProbe.successThreshold | int | `1` |  |
| php.livenessProbe.tcpSocket.port | int | `9000` |  |
| php.livenessProbe.timeoutSeconds | int | `2` |  |
| php.readinessProbe.failureThreshold | int | `3` |  |
| php.readinessProbe.initialDelaySeconds | int | `5` |  |
| php.readinessProbe.periodSeconds | int | `10` |  |
| php.readinessProbe.successThreshold | int | `1` |  |
| php.readinessProbe.tcpSocket.port | int | `9000` |  |
| php.readinessProbe.timeoutSeconds | int | `2` |  |
| php.resources | object | `{}` |  |
| php.secretEnv.PIMCORE_INSTALL_ADMIN_PASSWORD | string | `"admin"` |  |
| php.secretEnv.PIMCORE_INSTALL_ENCRYPTION_SECRET | string | `"your-encryption-secret"` |  |
| php.secretEnv.PIMCORE_INSTALL_MYSQL_PASSWORD | string | `"pimcore-password"` |  |
| php.secretEnv.PIMCORE_INSTALL_PRODUCT_KEY | string | `"your-product-key"` |  |
| php.securityContext.runAsGroup | int | `33` |  |
| php.securityContext.runAsUser | int | `33` |  |
| php.startupProbe.failureThreshold | int | `120` |  |
| php.startupProbe.initialDelaySeconds | int | `5` |  |
| php.startupProbe.periodSeconds | int | `5` |  |
| php.startupProbe.successThreshold | int | `1` |  |
| php.startupProbe.tcpSocket.port | int | `9000` |  |
| php.startupProbe.timeoutSeconds | int | `2` |  |
| php.volumeMounts | list | `[]` |  |
| pimecorePackage | string | `"pimcore/skeleton"` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.fsGroup | int | `33` |  |
| pvc.storage | string | `"10Gi"` |  |
| rabbitmq.affinity | object | `{}` |  |
| rabbitmq.auth.erlangCookie | string | `"my-erlang-cookie"` |  |
| rabbitmq.auth.password | string | `"bitnami"` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.enabled | bool | `true` |  |
| rabbitmq.persistence.enabled | bool | `true` |  |
| rabbitmq.persistence.size | string | `"2Gi"` |  |
| rabbitmq.resources | object | `{}` |  |
| rabbitmq.tolerations | list | `[]` |  |
| rabbitmqPassword | string | `"bitnami"` |  |
| rabbitmqUser | string | `"user"` |  |
| replicaCount | int | `1` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| supervisord.image.pullPolicy | string | `"IfNotPresent"` |  |
| supervisord.image.repository | string | `"pimcore/pimcore"` |  |
| supervisord.image.tag | string | `"php8.3.21-supervisord-v3.6"` |  |
| supervisord.securityContext.runAsGroup | int | `33` |  |
| supervisord.securityContext.runAsUser | int | `33` |  |
| terminationGracePeriodSeconds | int | `30` |  |
| tolerations | list | `[]` |  |
| valkey.architecture | string | `"standalone"` |  |
| valkey.auth.enabled | bool | `false` |  |
| valkey.enabled | bool | `true` |  |
| valkey.primary.affinity | object | `{}` |  |
| valkey.primary.extraFlags[0] | string | `"--maxmemory 128mb"` |  |
| valkey.primary.extraFlags[1] | string | `"--maxmemory-policy volatile-lru"` |  |
| valkey.primary.extraFlags[2] | string | `"--save \"\""` |  |
| valkey.primary.persistence.enabled | bool | `true` |  |
| valkey.primary.persistence.size | string | `"2Gi"` |  |
| valkey.primary.resources | object | `{}` |  |
| valkey.primary.tolerations | list | `[]` |  |
| volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
