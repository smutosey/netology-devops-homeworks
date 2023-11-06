terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.13"
    }
  }
}

# Создаем облачную сеть
resource "yandex_vpc_network" "vpc" {
  name = var.name
}

# Создаем подсеть в указанной зоне
resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.name}-${var.zone}"
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [var.cidr]
}