variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "frontend_private_ip" {}

variable "subnet_id" {
  type = string
}
variable "app_port" {
  default = 8080
}

variable "backend_nic_ids" {
  type = list(string)
}

