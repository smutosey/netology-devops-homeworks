resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "platform" {
  name        = local.web_name
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vm_web_resource_cores
    memory        = var.vm_web_resource_memory
    core_fraction = var.vm_web_resource_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_network_nat
  }

  metadata = {
    serial-port-enable = var.vm_web_serial_port_enable
    ssh-keys           = "${var.vm_web_user}:${var.vms_ssh_root_key}"
  }
}

resource "yandex_compute_instance" "platform-db" {
  name        = local.db_name
  platform_id = var.vm_db_platform
  resources {
    cores         = var.vm_db_resource_cores
    memory        = var.vm_db_resource_memory
    core_fraction = var.vm_db_resource_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_policy_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_network_nat
  }

  metadata = {
    serial-port-enable = var.vm_db_serial_port_enable
    ssh-keys           = "${var.vm_db_user}:${var.vms_ssh_root_key}"
  }
}
