output "vm_info" {
  value = flatten([
    for i, v in module.web-vm.external_ip_address : {
      module.web-vm.fqdn[i] = v
    }
  ])
}

resource "local_file" "inventory" {
  content = templatefile(
    "${path.module}/inventory.tftpl", {
      instances = {for i, v in module.web-vm.external_ip_address : module.web-vm.fqdn[i] => v}
    }
  )
  filename = "../playbook/inventory/prod.yml"
}