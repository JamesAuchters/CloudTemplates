provider "azurerm" {
  subscription_id             = "00000000-000000000-0000-000000000000"
  client_id                   = "00000000-000000000-0000-000000000000"
  client_certificate_path     = "C:\\SecureCertificatePath.pfx"
  client_certificate_password = "SuperSecurePassword"
  tenant_id                   = "00000000-000000000-0000-000000000000"
  version                     = "=1.24.0"
}

resource "azurerm_resource_group" "rg" {
  name = "TERRAFORM-RG01"
  location = "australiaeast"
}

resource "azurerm_virtual_network" "network" {
  name                = "production-network"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  address_space       = ["10.0.0.0/16"]
  subnet = {
    name = "SubnetOne"
    address_prefix = "10.0.1.0/24"
  }
}

resource "azurerm_subnet" "SubnetTwo" {
  name                 = "SubnetTwo"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.2.0/24"
}
resource "azurerm_network_interface" "demonic" {
  name                = "$demo-vm-nic"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name                          = "NICConfiguration"
    subnet_id                     = "${azurerm_subnet.SubnetTwo.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "demoVM" {
  name                  = "demo-vm"
  location              = "${azurerm_resource_group.rg.location}"
  resource_group_name   = "${azurerm_resource_group.rg.name}"
  network_interface_ids = ["${azurerm_network_interface.demonic.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "terraformserver"
    admin_username = "demoadmin"
    admin_password = "PUTASECUREPASSWORDHEREPLEASEFORTHELOVEOFGOD123\\aa"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}