resource "azurerm_backup_policy_vm" "policy" {
  name                = "daily-vm-backup-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.vault_name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count    = 4
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }
}
