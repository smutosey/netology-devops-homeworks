# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = null
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = null
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "yc-debian-custom" {
  default = null
}

variable "yandex_region" {
  default = null
}