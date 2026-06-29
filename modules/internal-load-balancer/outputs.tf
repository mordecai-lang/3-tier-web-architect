output "lb_private_ip" {
  value = var.frontend_private_ip
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.pool.id
}

