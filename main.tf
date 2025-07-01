provider "azurerm" {
  features {}
}

# custom image
data "azurerm_image" "custom_image" {
  name                = var.image_name
  resource_group_name = var.image_resource_group
}

# Use existing virtual network
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

# Use existing subnet
data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
}

# Use existing NSG
data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}

# Create a NIC, associate with NSG
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${var.vm_name}"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  network_security_group_id = data.azurerm_network_security_group.nsg.id
}

# Create ephemeral VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]

  source_image_id = data.azurerm_image.custom_image.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = {
    environment = "ephemeral"
  }
}
