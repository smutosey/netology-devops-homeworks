output "vm_info" {
  value = flatten([
    [for i in yandex_compute_instance.web : {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }],
    [for i in yandex_compute_instance.backend : {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }],
    [for i in [yandex_compute_instance.storage] : {
      name = i.name
      id   = i.id
      fqdn = i.fqdn
    }]
  ])
}