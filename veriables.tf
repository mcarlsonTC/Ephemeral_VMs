variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for the VM"
  type        = string
}

variable "image_name" {
  description = "Name of the custom image"
  type        = string
}

variable "image_resource_group" {
  description = "Resource Group containing the custom image"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B2ms"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "vnet_name" {
  type        = string
  description = "Name of existing VNet"
}

variable "subnet_name" {
  type        = string
  description = "Name of existing Subnet"
}

variable "nsg_name" {
  type        = string
  description = "Name of existing NSG"
}
