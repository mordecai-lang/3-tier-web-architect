
#load balancer public ip address
output "lb_public_ip" {
  value = module.load_balancer.lb_public_ip
}

#weblv vm nic ids
output "web_lbvm1_nic" {
  value = module.web_lbvm1_nic.nic_id
}


output "web_lbvm2_nic" {
  value = module.web_lbvm2_nic.nic_id
}
#Vnets

output "VNet_id" {
  value = module.virtual_network.vnet_id
}

output "VNet_name" {
  value = module.virtual_network.vnet_name
}
#web vms subnet ids
output "web_lbvm1_subnet_id" {
  value = module.web_lbvm1_subnet.subnet_id
}

output "web_lbvm2_subnet_id" {
  value = module.web_lbvm2_subnet.subnet_id
}

output "database_subnet_id" {
  value = module.database_subnet.subnet_id
}

#nsg ids
output "web1nsg_id" {
  value = module.web_nsg.nsg_id
}

output "appnsg_id" {
  value = module.app_nsg.nsg_id
}

output "dbnsg_id" {
  value = module.db_nsg.nsg_id
}

#nsg rules id
output "web_http_rule_id" {
  value = module.web1_http_rule.nsg_rule_id
}

output "web2__http_rule_id" {
  value = module.web2_http_rule.nsg_rule_id
}

output "web1_deny_rule_id" {
  value = module.web1_deny_rule.nsg_rule_id
}

output "web2_deny_rule_id" {
  value = module.web2_deny_rule.nsg_rule_id
}

output "web1_apps_allow_rule" {
  value = module.web1_apps_allow_rule.nsg_rule_id
}

output "web2_apps_allow_rule" {
  value = module.web2_apps_allow_rule.nsg_rule_id
}
output "app1_database_allow_rule" {
  value = module.app1_database_allow_rule.nsg_rule_id
}

output "app2_database_allow_rule" {
  value = module.app2_database_allow_rule.nsg_rule_id
}

output "web1_database_deny_rule" {
  value = module.web1_database_deny_rule.nsg_rule_id
}

output "web2_database_deny_rule" {
  value = module.web2_database_deny_rule.nsg_rule_id
}

#web lbvms nic association ids
output "web_lbvm1_nsg_association_id" {
  value = module.web_lbvm1_nsg_association.association_id
}

output "web_lbvm2_nsg_association_id" {
  value = module.web_lbvm2_nsg_association.association_id
}
output "app_vm1_nsg_association" {
  value = module.app_vm1_nsg_association.association_id
}

#virtual machines ids
/*output "web_lbvm1_id" {
  value = module.web_lbvm1.vm_id
}

output "web_lbvm2_id" {
  value = module.web_lbvm2.vm_id
}

output "app_vm1_id" {
  value = module.app_vm.vm_id
}
*/

#backend pool id
output "backend_pool_id" {
  value = module.load_balancer.backend_pool_id
}

#backend pool association id
output "web_lbvm1_backend_assoc" {
  value = module.web_lbvm1_backend_assoc.backend_assoc_id
}

output "web_lbvm2_backend_assoc" {
  value = module.web_lbvm2_backend_assoc.backend_assoc_id
}

#database
/*output "mysql_server_name" {
  value = module.database.server_name
}

output "mysql_server_id" {
  value = module.database.server_id
}

output "mysql_fqdn" {
  value = module.database.fqdn
}

output "mysql_database_id" {
  value = module.database.database_id
}*/

/*output "mysql_database_name" {
  value = module.database.database_name
}

output "private_dns_zone_name" {
  value = module.database.private_dns_zone_name
}

output "private_dns_zone_id" {
  value = module.database.private_dns_zone_name
}

output "private_dns_zone_link_name" {
  value = module.database.private_dns_zone_link_name
}


output "private_dns_zone_link_id" {
  value = module.database.private_dns_zone_link_id
}

output "private_endpoint_name" {
  value = module.database.private_endpoint_name
}

output "private_endpoint_id" {
  value = module.database.private_endpoint_id
}*/

/*#Internal load balancer
output "lb_private_ip" {
  value = module.internal_lb.lb_private_ip
}

output "internal_lb_backend_pool_id" {
  value = module.internal_lb.backend_pool_id
}

#monitoring and disaster recovery
output "vault_name" {
  value = module.recovery_vault.vault_name
}

output "backup_policy_id" {
  value = module.backup_policy.policy_id
}
*/
