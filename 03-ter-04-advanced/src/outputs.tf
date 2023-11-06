output "vm_info" {
  value = flatten([
    for i, v in module.web-vm.external_ip_address : {
      module.web-vm.fqdn[i] = v
    }
  ])
}