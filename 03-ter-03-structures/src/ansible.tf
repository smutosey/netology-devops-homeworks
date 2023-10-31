resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.backend
    storage    = [yandex_compute_instance.storage]
  })
  filename = "${abspath(path.module)}/inventory.cfg"
}