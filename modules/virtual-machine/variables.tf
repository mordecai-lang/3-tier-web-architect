variable "resource_group_name" {
  type = string
}

variable "vm_name" {
  type = string

}

variable "location" {
  type = string
}

variable "network_interface_id" {
  type = list(string)
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}


variable "ssh_public_key_path" {
  type = string
}
