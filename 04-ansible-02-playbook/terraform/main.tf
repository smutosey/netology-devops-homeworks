module "vpc_prod" {
  source  = "../../03-ter-04-advanced/src/vpc"
  name    = var.prod_env.vpc_name
  subnets = var.prod_env.subnets
}

module "web-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id      = module.vpc_prod.network.id
  subnet_zones    = [var.vm_params.zone]
  subnet_ids      = [module.vpc_prod.subnet[var.vm_params.zone].id]
  instance_name   = var.vm_params.instance_name
  instance_count  = var.vm_params.count
  instance_cores  = var.vm_params.instance_cores
  instance_memory = var.vm_params.instance_memory
  boot_disk_size  = var.vm_params.boot_disk_size
  image_family    = var.vm_params.image_family
  public_ip       = var.vm_params.public_ip

  metadata = {
    user-data          = data.template_file.web_cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "web_cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.username
    ssh_public_key = file(var.ssh_public_key)
    packages       = jsonencode(var.web_packages)
  }
}