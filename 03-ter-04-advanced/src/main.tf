#module "vpc" {
#  source   = "./vpc"
#  name = "develop"
#  zone = "ru-central1-a"
#  cidr = "10.0.1.0/24"
#}

module "vpc_dev" {
  source = "./vpc"
  name   = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.10.0/24" }
  ]
}
module "vpc_prod" {
  source = "./vpc"
  name   = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "web-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_dev.network.id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_dev.subnet["ru-central1-a"].id]
  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

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