/*module "resource_group" {
  source   = "./modules/resource-group"
  name     = "${var.environment}-rg"
  location = var.location

  tags = var.tags
} */

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}


#load balancer + public IP
module "load_balancer" {
  source   = "./modules/load-balancer"
  lb_name  = "${var.environment}-loadbalancer"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

#VNet
module "virtual_network" {
  source   = "./modules/vnet"
  name     = "${var.environment}-vnet"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space
  tags                = var.tags
}

#Subnets
#web-lb-vm1-subnet
module "web_lbvm1_subnet" {
  source               = "./modules/subnet"
  name                 = "${var.environment}-webvm1-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[0]]
}

#web lb-vm2-subnet
module "web_lbvm2_subnet" {
  source               = "./modules/subnet"
  name                 = "${var.environment}-webvm2-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[1]]
}

#database subnet
module "database_subnet" {
  source               = "./modules/subnet"
  name                 = "${var.environment}-database-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[2]]
}

module "app_vm1_subnet" {
  source               = "./modules/subnet"
  name                 = "${var.environment}-appvm1-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name 
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[3]]
}

module "app_vm2_subnet" {
  source               = "./modules/subnet"
  name                 = "${var.environment}-appvm2-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[4]]
}


#bastion subnet
module "bastion_subnet" {
  source               = "./modules/subnet"
  name                 = "AzureBastionSubnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.azure_bastion_subnet[0]]
}

#internal load balancer subnet
module "ilb_subnet" {
  source               = "./modules/subnet"
  name                 = "internal-load-balancer-subnet"
  virtual_network_name = module.virtual_network.vnet_name
  #resource_group_name  = module.resource_group.resource_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  address_prefixes    = [var.subnet_address_prefix[5]]
}



#NSG
module "web_nsg" {
  source   = "./modules/nsg"
  name     = "${var.environment}-Web-NSG"
  location = var.location
  #  resource_group_name = module.resource_group.resource_group>
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

module "app_nsg" {
  source   = "./modules/nsg"
  name     = "${var.environment}-App-NSG"
  location = var.location
  #  resource_group_name = module.resource_group.resource_group>
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

module "db_nsg" {
  source   = "./modules/nsg"
  name     = "${var.environment}-DB-NSG"
  location = var.location
  #  resource_group_name = module.resource_group.resource_group>
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = var.tags
}

#NSG rules
#Allow HTTP on vm1
module "web1_ssh_rule" {
  source    = "./modules/nsg-rule"
  name      = "WebVm1-Allow-SSH-From-VNet"
  direction = "Inbound"
  priority  = 112
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = var.subnet_address_prefix[0]

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.web_nsg.nsg_name
}

module "web2_ssh_rule" {
  source    = "./modules/nsg-rule"
  name      = "WebVm2-Allow-SSH-From-VNet"
  direction = "Inbound"
  priority  = 113
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = var.subnet_address_prefix[1]

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.web_nsg.nsg_name
}

module "app1_ssh_rule" {
  source    = "./modules/nsg-rule"
  name      = "Appvm1-Allow-SSH-From-VNet"
  direction = "Inbound"
  priority  = 102
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = var.subnet_address_prefix[3]

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.app_nsg.nsg_name
}

module "app2ssh_rule" {
  source    = "./modules/nsg-rule"
  name      = "Appvm1-Allow-SSH-From-VNet"
  direction = "Inbound"
  priority  = 110
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "VirtualNetwork"
  destination_address_prefix = var.subnet_address_prefix[4]

  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = module.app_nsg.nsg_name
}


module "web1_http_rule" {
  source    = "./modules/nsg-rule"
  name      = "WebVm1-Allow-HTTP-From-LoadBalancer"
  direction = "Inbound"
  priority  = 109
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = var.subnet_address_prefix[0]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #  resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.web_nsg.nsg_name
}

#Allow Http on Vweb M2
module "web2_http_rule" {
  source    = "./modules/nsg-rule"
  name      = "WebVm2-Allow-HTTP-From-LoadBalancer"
  direction = "Inbound"
  priority  = 101
  protocol  = "Tcp"
  access    = "Allow"

  source_port_range          = "*"
  destination_port_range     = "80"
  source_address_prefix      = "AzureLoadBalancer"
  destination_address_prefix = var.subnet_address_prefix[1]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #  resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.web_nsg.nsg_name
}

#Deny other inbound to web vm1
module "web1_deny_rule" {
  source    = "./modules/nsg-rule"
  name      = "Deny-Other-Inbound-to-Webvm1"
  direction = "Inbound"
  priority  = 210
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = var.subnet_address_prefix[0]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #  resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.web_nsg.nsg_name
}

#deny other inbound to vm 2
module "web2_deny_rule" {
  source    = "./modules/nsg-rule"
  name      = "Deny-Other-Inbound-to-webvm2"
  direction = "Inbound"
  priority  = 211
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = var.subnet_address_prefix[1]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.web_nsg.nsg_name
}


#Alow web to app 
module "web1_apps_allow_rule" {
  source    = "./modules/nsg-rule"
  name      = "Allow-web1-to-all-App"
  direction = "Inbound"
  priority  = 114
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "80"
  destination_port_range     = "8080"
  source_address_prefix      = var.subnet_address_prefix[0]
  destination_address_prefix = "*"
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.app_nsg.nsg_name
}

#Alow web2 to app 
module "web2_apps_allow_rule" {
  source    = "./modules/nsg-rule"
  name      = "Allow-web2-to-all-App"
  direction = "Inbound"
  priority  = 103
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "80"
  destination_port_range     = "8080"
  source_address_prefix      = var.subnet_address_prefix[1]
  destination_address_prefix = "*"
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.app_nsg.nsg_name
}


#Allow App VM1 to database inbound rule
module "app1_database_allow_rule" {
  source    = "./modules/nsg-rule"
  name      = "Allow-Appvm1-to-database"
  direction = "Inbound"
  priority  = 104
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "8080"
  destination_port_range     = "3306"
  source_address_prefix      = var.subnet_address_prefix[3]
  destination_address_prefix = var.subnet_address_prefix[2]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.db_nsg.nsg_name
}

#Allow App VM2 to database inbound rule
module "app2_database_allow_rule" {
  source    = "./modules/nsg-rule"
  name      = "Allow-Appvm2-to-database"
  direction = "Inbound"
  priority  = 105
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "8080"
  destination_port_range     = "3306"
  source_address_prefix      = var.subnet_address_prefix[4]
  destination_address_prefix = var.subnet_address_prefix[2]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.db_nsg.nsg_name
}

#Deny Web VM1 to database inbound rule
module "web1_database_deny_rule" {
  source    = "./modules/nsg-rule"
  name      = "Deny-Webvm1-to-database"
  direction = "Inbound"
  priority  = 107
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "80"
  destination_port_range     = "3306"
  source_address_prefix      = var.subnet_address_prefix[0]
  destination_address_prefix = var.subnet_address_prefix[2]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.db_nsg.nsg_name
}

#Deny Web VM2 to database inbound rule
module "web2_database_deny_rule" {
  source    = "./modules/nsg-rule"
  name      = "Deny-Webvm2-to-database"
  direction = "Inbound"
  priority  = 108
  protocol  = "Tcp"
  access    = "Deny"

  source_port_range          = "80"
  destination_port_range     = "3306"
  source_address_prefix      = var.subnet_address_prefix[1]
  destination_address_prefix = var.subnet_address_prefix[2]
  resource_group_name        = data.azurerm_resource_group.rg.name
  #resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = module.db_nsg.nsg_name
}



#MySQL server and database 
/*module "database" {
  source                     = "./modules/database"
  mysql_server_name          = "${var.environment}-mordecai-mysqlserver"
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = var.location
  database_name              = "task_manager"
  admin_username             = var.mysql_admin_username
  admin_password             = var.mysql_admin_password
  vnet_id                    = module.virtual_network.vnet_id
  private_endpoint_subnet_id = module.database_subnet.subnet_id
}
*/
#Bastion
module "bastion" {
  source              = "./modules/bastion"
  name                = "${var.environment}-bastion"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  bastion_subnet_id   = module.bastion_subnet.subnet_id
}
#NICs
module "web_lbvm1_nic" {
  source   = "./modules/network-interface"
  name     = "${var.environment}-webvm1-nic"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_n>
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.web_lbvm1_subnet.subnet_id
}
module "web_lbvm2_nic" {
  source   = "./modules/network-interface"
  name     = "${var.environment}-webvm2-nic"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_n>
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.web_lbvm2_subnet.subnet_id
}
module "appvm1_nic" {
  source   = "./modules/network-interface"
  name     = "${var.environment}-appvm1-nic"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_n>
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.app_vm1_subnet.subnet_id
}

module "appvm2_nic" {
  source   = "./modules/network-interface"
  name     = "${var.environment}-appvm2-nic"
  location = var.location
  #resource_group_name = module.resource_group.resource_group_n>
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = module.app_vm2_subnet.subnet_id
}

#NSG association
module "web_lbvm1_nsg_association" {
  source = "./modules/nsg-association"

  network_interface_id      = module.web_lbvm1_nic.nic_id
  network_security_group_id = module.web_nsg.nsg_id
}

module "web_lbvm2_nsg_association" {
  source = "./modules/nsg-association"

  network_interface_id      = module.web_lbvm2_nic.nic_id
  network_security_group_id = module.web_nsg.nsg_id
}

module "app_vm1_nsg_association" {
  source = "./modules/nsg-association"

  network_interface_id      = module.appvm1_nic.nic_id
  network_security_group_id = module.app_nsg.nsg_id
}

module "app_vm2_nsg_association" {
  source = "./modules/nsg-association"

  network_interface_id      = module.appvm2_nic.nic_id
  network_security_group_id = module.app_nsg.nsg_id
}

#vm 1
module "web_lbvm1" {
  source   = "./modules/virtual-machine"
  vm_name  = "${var.environment}-webvm1"
  location = var.location
  #resource_group_name   = module.resource_group.resource_group>
  resource_group_name  = data.azurerm_resource_group.rg.name
  network_interface_id = [module.web_lbvm1_nic.nic_id]
  ssh_public_key_path  = var.ssh_public_key_path
  vm_size              = var.vm_size
  admin_username       = var.admin_username

}

module "web_lbvm2" {
  source   = "./modules/virtual-machine"
  vm_name  = "${var.environment}-webvm2"
  location = var.location
  #resource_group_name   = module.resource_group.resource_group>
  resource_group_name  = data.azurerm_resource_group.rg.name
  network_interface_id = [module.web_lbvm2_nic.nic_id]
  ssh_public_key_path  = var.ssh_public_key_path
  vm_size              = var.vm_size
  admin_username       = var.admin_username
}

module "app_vm1" {
  source   = "./modules/virtual-machine"
  vm_name  = "${var.environment}-appvm1"
  location = var.location
  #resource_group_name   = module.resource_group.resource_group>
  resource_group_name  = data.azurerm_resource_group.rg.name
  network_interface_id = [module.appvm1_nic.nic_id]
  ssh_public_key_path  = var.ssh_public_key_path
  vm_size              = var.vm_size
  admin_username       = var.admin_username
}

module "app_vm2" {
  source   = "./modules/virtual-machine"
  vm_name  = "${var.environment}-appvm2"
  location = var.location
  #resource_group_name   = module.resource_group.resource_group.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  network_interface_id = [module.appvm2_nic.nic_id]
  ssh_public_key_path  = var.ssh_public_key_path
  vm_size              = var.vm_size
  admin_username       = var.admin_username
}


#Backend pool association
module "web_lbvm1_backend_assoc" {
  source                  = "./modules/backend-association"
  network_interface_id    = module.web_lbvm1_nic.nic_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = module.load_balancer.backend_pool_id
}

module "web_lbvm2_backend_assoc" {
  source                  = "./modules/backend-association"
  network_interface_id    = module.web_lbvm2_nic.nic_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = module.load_balancer.backend_pool_id
}

#internal load balancer association
module "internal_lb" {
  source              = "./modules/internal-load-balancer"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  frontend_private_ip = "10.10.6.10"
  subnet_id           = module.ilb_subnet.subnet_id
  backend_nic_ids = [
    module.appvm1_nic.nic_id,
    module.appvm2_nic.nic_id
  ]
}

#monitoring and disaster recovery
/*resource "azurerm_resource_group" "secondary_rg" {
  name     = "${var.resource_group_name}-dr"
  location = var.secondary_location
}

module "recovery_vault" {
  source              = "./modules/recovery-vault"
  name                = var.recovery_vault_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

module "backup_policy" {
  source              = "./modules/backup-policy-vm"
  resource_group_name = data.azurerm_resource_group.rg.name
  vault_name          = module.recovery_vault.vault_name
}

  source              = "./modules/vm-backup"
  resource_group_name = data.azurerm_resource_group.rg.name
  vault_name          = var.recovery_vault_name
  vault_id            = module.recovery_vault.vault_id
  backup_policy_id    = module.backup_policy.policy_id
  vm_ids              = [module.web_lbvm1.vm_id, module.web_lbvm2.vm_id, module.appvm1.vm_id, ]
}

module "metric_alert" {
  source              = "./modules/monitoring"
  resource_group_name = data.azurerm_resource_group.rg.name
  email_receiver      = var.email_receiver
  vm_ids              = [module.web_lbvm1.vm_id, module.web_lbvm2.vm_id, module.appvm1.vm_id, ]
  location            = azurerm_resource_group.dr_rg.location
}*/





