output "vm_external_ip" {
  description = "External IP address of instances"
  value = {
    (yandex_compute_instance.platform.name)    = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    (yandex_compute_instance.platform-db.name) = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address
  }
}

output "admin_server_info" {
  value = "${local.test_map.admin} is admin for ${local.test_list[2]} server based on OS ${local.servers[local.test_list[2]].image} with ${local.servers[local.test_list[2]].cpu} vcpu, ${local.servers[local.test_list[2]].ram} ram, and ${length(local.servers[local.test_list[2]].disks)} virtual disks (${join(", ", local.servers[local.test_list[2]].disks)})"
}