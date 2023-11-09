## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >=0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >=0.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_mysql_cluster.mysql](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_HA"></a> [HA](#input\_HA) | Sets whether the cluster should be a High-Availability(HA) MySQL Cluster | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment of the MySQL cluster | `string` | `"PRESTABLE"` | no |
| <a name="input_hosts"></a> [hosts](#input\_hosts) | A host(s) of the MySQL cluster | <pre>object({<br>    assign_public_ip = bool<br>    subnets = list(object({<br>      zone = string<br>      id = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_maintenance"></a> [maintenance](#input\_maintenance) | Maintenance policy of the MySQL cluster | <pre>object({<br>    type = string<br>    day  = string<br>    hour = number<br>  })</pre> | <pre>{<br>  "day": "SAT",<br>  "hour": 12,<br>  "type": "WEEKLY"<br>}</pre> | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | Version of the MySQL cluster. (allowed versions are: 5.7, 8.0) | `string` | `"8.0"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the MySQL cluster | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the network, to which the MySQL cluster uses | `string` | n/a | yes |
| <a name="input_resources"></a> [resources](#input\_resources) | Resources allocated to hosts of the MySQL cluster | <pre>object({<br>    preset    = string<br>    disk_type = string<br>    disk_size = number<br>  })</pre> | <pre>{<br>  "disk_size": 10,<br>  "disk_type": "network-hdd",<br>  "preset": "b1.medium"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
