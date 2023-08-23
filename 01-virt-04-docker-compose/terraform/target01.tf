resource "yandex_compute_instance" "target01" {
  name                      = "target01"
  zone                      = "ru-central1-b"
  hostname                  = "target01.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = var.yc-debian-custom
      name        = "root-target01"
      type        = "network-nvme"
      size        = "30"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_rsa.pub")}"
  }
}
