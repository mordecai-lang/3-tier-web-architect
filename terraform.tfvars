location            = "East US"
resource_group_name = "mordecai-rg"
vm_size             = "Standard_D2s_v3"
environment         = "test"
vm_name             = "mordecai-vm"
admin_username      = "mordecai"

ssh_public_key_path = "ssh/id_rsa.pub"

subnet_address_prefix = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/28"]
address_space         = ["10.10.0.0/16"]
azure_bastion_subnet  = ["10.10.255.0/26"]
tags = {
  Environment = "test"
  Owner       = "DevOps"
  ManagedBy   = "terraform"
}

#mysql_server_name    = "mordecaiSQL"
#mysql_admin_username = "mordecai"
#mysql_admin_password = "John3:16"
