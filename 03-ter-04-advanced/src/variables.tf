###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "username" {
  type        = string
  description = "name of predefined user on VM"
  default     = "nedorezov"
}

variable "ssh_public_key" {
  type        = string
  description = "Location of SSH public key."
  default     = "~/.ssh/id_ed25519.pub"
}

variable "web_packages" {
  type    = list(string)
  default = ["vim", "nginx"]
}

variable "vm_params" {
  type = object({
    count = number
    env_name = string
    instance_name = string
    zone = string
    image_family = string
    public_ip = bool
  })
  description = "params for Web VMs"
  default = {
    count = 1
    env_name = "develop"
    instance_name = "web"
    zone = "ru-central1-a"
    image_family = "ubuntu-2004-lts"
    public_ip = true
  }
}

variable "dev_env" {
  type = object({
    vpc_name = string
    subnets = list(object({
      zone = string
      cidr = string
    }))
  })
  description = "DEV environment variables"
  default = {
    vpc_name = "develop"
    subnets = [
      { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    ]
  }
}

variable "prod_env" {
  type = object({
    vpc_name = string
    subnets = list(object({
      zone = string
      cidr = string
    }))
  })
  description = "PROD environment variables"
  default = {
    vpc_name = "production"
    subnets = [
      { zone = "ru-central1-a", cidr = "10.0.10.0/24" },
      { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
      { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
    ]
  }
}

variable "mysql_env" {
  type = object({
    cluster_name = string
    high_availability = bool
    assign_public_ip = bool
    database = map(string)
  })
  description = "MySQL cluster and database params"
  default = {
    cluster_name = "mysql_cluster"
    high_availability = false
    assign_public_ip = false
    database = {
      name = "test"
      username = "app"
    }
  }
}

variable "mysql_password" {
  type = string
  description = "Password for MySQL database user"
}