/*resource "azurerm_monitor_action_group" "action_group" {
  name                = "vm-action-group"
  resource_group_name = var.resource_group_name
  short_name          = "vmact"

  email_receiver {
    name          = "admin"
    email_address = var.email_receiver
  }
}

#multi vm cpu metric alerts
resource "azurerm_monitor_metric_alert" "cpu" {
  for_each = toset(var.vm_ids)

  name                = "high-cpu-${each.key}"
  resource_group_name = var.resource_group_name
  scopes              = [each.value]
  description         = "CPU alert for VM"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Avarage"
    operator         = GreaterThan
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }

}

#storage disk alert
resource "azurerm_monitor_metric_alert" "disk" {
  for_each = toset(var.vm_ids)

  name                = "disk-alert-${each.key}"
  resource_group_name = var.resource_group_name
  scopes              = [each.value]
  description         = "Disk alert for VM"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Logical Disk Free Space"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 10
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group.id
  }

}*/
