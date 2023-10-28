output "vm_external_ip" {
  description = "External IP address of instance"
  value       = {
    "platform" = yandex_compute_instance.platform.network_interface.0.nat_ip_address
  }
}