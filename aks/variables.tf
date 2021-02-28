## ..:: Azure AKS Variables ::..
## ---------------------------------------------------------------------------

variable "how_many_nodes" {
  description = ""
  type = number
}

variable "cluster_name" {
  description = ""
  type = string
}

variable "azure_vm_size" {
  description = ""
  type = string
  default = "Standard_DS3_v2"
}

variable "vnet_name" {
  description = ""
  type = string
}

variable "subnet_name" {
  description = ""
  type = string
}