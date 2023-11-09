variable "student" {
  type        = map(string)
  description = "it's me"  # <- personal.auto.tfvars
}

variable "token" {
  type        = string
  description = "vault auth token (root) " # <- personal.auto.tfvars
}