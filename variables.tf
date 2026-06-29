variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "environment" {
  type = string
}

#vm variables

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "tags" {
  type = map(string)
}
variable "ssh_public_key_path" {
  type = string
}

#VNet variables
variable "address_space" {
  type = list(string)
}

#Subnet variables
variable "subnet_address_prefix" {
  type = list(string)
}
#bastion subnet
variable "azure_bastion_subnet" {
  type = list(string)
}

#database
/*variable "mysql_server_name" {
  type = string
}

variable "mysql_admin_username" {
  type = string
}

variable "mysql_admin_password" {
  type = string
}
*/
#monitoring and disaster recovery
/*variable "primary_location" {
  default = "East US"
}
variable "secondary_location" {
  default = "West US"
}

variable "recovery_vault_name" {}
variable "vm_id" {}

variable "email_receiver" {
  type = string
}*/
