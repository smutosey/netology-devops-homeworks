terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 2
}

resource "virtualbox_vm" "vm_netology" {
  name   = "centos-7"
  image  = "https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.2/vagrant-centos-7.2.box"
  cpus      = 1
  status    = "running"
  memory    = "512 mib"

  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddress" {
  value = element(virtualbox_vm.vm_netology.*.network_adapter.0.ipv4_address, 1)
}