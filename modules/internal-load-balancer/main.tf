resource "azurerm_lb" "internal_lb" {
  name                = "appilb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "frontend"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.frontend_private_ip
  }
}

resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.internal_lb.id
  name            = "app-pool"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.internal_lb.id
  name            = "app-probe"
  protocol        = "Tcp"
  port            = var.app_port
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.internal_lb.id
  name                           = "app-rule"
  protocol                       = "Tcp"
  frontend_port                  = var.app_port
  backend_port                   = var.app_port
  frontend_ip_configuration_name = "frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  count                   = length(var.backend_nic_ids)
  network_interface_id    = var.backend_nic_ids[count.index]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}

