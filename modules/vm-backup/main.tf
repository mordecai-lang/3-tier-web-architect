/*resource "azurerm_backup_protected_vm" "vm_backup" {
  for_each            = toset(var.vm_ids)
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.vault_name
  source_vm_id        = each.value
  backup_policy_id    = var.backup_policy_id
}
*/
