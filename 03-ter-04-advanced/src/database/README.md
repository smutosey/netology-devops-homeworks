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
| [yandex_mdb_mysql_database.db](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_database) | resource |
| [yandex_mdb_mysql_user.db_user](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | `"test"` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | `"app"` | no |

## Outputs

No outputs.
