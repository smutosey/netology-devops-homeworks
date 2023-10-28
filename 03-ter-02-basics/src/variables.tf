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
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKWdwZ3ITR9ceNI5R/BcOHUf9H3G/i/u2MkOGk945cUI nedorezov@GARRO"
  description = "ssh-keygen -t ed25519"
}

###vm vars

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "instance name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform id"
}

variable "vm_web_resource_cores" {
  type        = number
  default     = 2
  description = "number of vCPU cores"
}

variable "vm_web_resource_memory" {
  type        = number
  default     = 1
  description = "VM memory"
}

variable "vm_web_resource_core_fraction" {
  type        = number
  default     = 5
  description = "baseline performance for a core as a percent"
}

variable "vm_web_policy_preemptible" {
  type        = bool
  default     = true
  description = "if the instance is preemptible"
}

variable "vm_web_network_nat" {
  type        = bool
  default     = true
  description = "Provide a public address, for instance, to access the internet over NAT"
}

variable "vm_web_serial_port_enable" {
  type        = number
  default     = 1
  description = "Access to serial console"
}

variable "vm_web_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}