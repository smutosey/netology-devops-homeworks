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
  default = ["vim"]
}
