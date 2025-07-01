output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "vm_ip" {
  value = azurerm_windows_virtual_machine.vm.public_ip_address
}
