output "vm_external_ip" {
  description = "External IP address of instances"
  value = {
    for i, v in module.cicd.external_ip_address : module.cicd.fqdn[i] => v
  }
}