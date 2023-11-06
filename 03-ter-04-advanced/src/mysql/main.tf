terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">=0.13"
    }
  }
}

resource "yandex_mdb_mysql_cluster" "mysql" {
  name        = var.name
  environment = var.environment
  network_id  = var.network_id
  version     = var.mysql_version

  resources {
    resource_preset_id = var.resources.preset
    disk_type_id       = var.resources.disk_type
    disk_size          = var.resources.disk_size
  }

  maintenance_window {
    type = var.maintenance.type
    day  = var.maintenance.day
    hour = var.maintenance.hour
  }

  dynamic "host" {
    for_each = var.HA ? [1, 2] : [1]
    content {
      assign_public_ip = var.hosts.assign_public_ip
      subnet_id        = var.hosts.subnets[host.key].id
      zone             = var.hosts.subnets[host.key].zone
    }
  }
}