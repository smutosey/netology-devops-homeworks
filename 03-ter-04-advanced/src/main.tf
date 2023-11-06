#module "vpc" {
#  source   = "./vpc"
#  name = "develop"
#  zone = "ru-central1-a"
#  cidr = "10.0.1.0/24"
#}

module "vpc_dev" {
  source  = "./vpc"
  name    = var.dev_env.vpc_name
  subnets = var.dev_env.subnets
}
module "vpc_prod" {
  source  = "./vpc"
  name    = var.prod_env.vpc_name
  subnets = var.prod_env.subnets
}

module "mysql_cluster" {
  source     = "./mysql"
  name       = var.mysql_env.cluster_name
  network_id = module.vpc_prod.network.id
  HA         = var.mysql_env.high_availability
  hosts = {
    assign_public_ip = var.mysql_env.assign_public_ip
    subnets          = module.vpc_prod.subnets
  }
}

module "mysql_database" {
  source       = "./database"
  cluster_id   = module.mysql_cluster.cluster_id
  db_name      = var.mysql_env.database.name
  username     = var.mysql_env.database.username
  password     = var.mysql_password
}


module "web-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vm_params.env_name
  network_id     = module.vpc_dev.network.id
  subnet_zones   = [var.vm_params.zone]
  subnet_ids     = [module.vpc_dev.subnet[var.vm_params.zone].id]
  instance_name  = var.vm_params.instance_name
  instance_count = var.vm_params.count
  image_family   = var.vm_params.image_family
  public_ip      = var.vm_params.public_ip

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