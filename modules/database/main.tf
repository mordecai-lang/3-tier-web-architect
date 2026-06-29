/*resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.mysql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  sku_name = var.sku_name
  version  = "8.0.21"

  backup_retention_days = 7

}

resource "azurerm_mysql_flexible_database" "database" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_private_dns_zone" "mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysql" {
  name                  = "${var.mysql_server_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql.name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}

resource "azurerm_private_endpoint" "mysql_pe" {
  name                = "${var.mysql_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  private_service_connection {
    name                           = "${var.mysql_server_name}-psc"
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "mysql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.mysql.id]
  }
}*/
