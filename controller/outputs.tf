#resource "local_file" "inventory" {
#  content = templatefile(
#    "${path.module}/inventory.tftpl", {
#      lighthouse    = { for i, v in module.controller.external_ip_address : module.lighthouse.fqdn[i] => v }
#    }
#  )
#  filename = "../playbook/inventory/prod.yml"
#}

output "vm_external_ip" {
  description = "External IP address of instances"
  value = {
    for i, v in module.controller.external_ip_address : module.controller.fqdn[i] => v
  }
}

#   (module.controller.fqdn)    = module.controller.external_ip_address