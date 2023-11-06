variable "name" {
  type        = string
  description = "Name of the MySQL cluster"
}

variable "environment" {
  type        = string
  description = "Deployment environment of the MySQL cluster"
  default     = "PRESTABLE"
}

variable "network_id" {
  type        = string
  description = "ID of the network, to which the MySQL cluster uses"
}

variable "mysql_version" {
  type        = string
  description = "Version of the MySQL cluster. (allowed versions are: 5.7, 8.0)"
  default     = "8.0"
}

variable "resources" {
  type = object({
    preset    = string
    disk_type = string
    disk_size = number
  })
  description = "Resources allocated to hosts of the MySQL cluster"
  default = {
    preset    = "b1.medium"
    disk_type = "network-hdd"
    disk_size = 10
  }
}

variable "maintenance" {
  type = object({
    type = string
    day  = string
    hour = number
  })
  description = "Maintenance policy of the MySQL cluster"
  default = {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }
}

variable "HA" {
  type = bool
  description = "Sets whether the cluster should be a High-Availability(HA) MySQL Cluster"
}

variable "hosts" {
  type = object({
    assign_public_ip = bool
    subnets = list(object({
      zone = string
      id = string
    }))
  })
  description = "A host(s) of the MySQL cluster"
}

