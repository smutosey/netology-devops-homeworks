module "cicd" {
  source             = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id         = module.vpc_prod.network.id
  subnet_zones       = [var.cicd_params.zone]
  subnet_ids         = [module.vpc_prod.subnet[var.cicd_params.zone].id]
  instance_name      = var.cicd_params.instance_name
  instance_count     = var.cicd_params.count
  instance_cores     = var.cicd_params.instance_cores
  instance_memory    = var.cicd_params.instance_memory
  boot_disk_size     = var.cicd_params.boot_disk_size
  image_family       = var.cicd_params.image_family
  public_ip          = var.cicd_params.public_ip

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