variable "adminpc_image" {
  type        = string
  description = "image of the adminpc host"
}

variable "adminpc_flavor" {
  type        = string
  description = "flavor of the adminpc host"
  default     = "d2-2"
}

variable "adminpc_userdata" {
  type        = string
  description = "Userdata for the adminpc virtual machine"
  default     = null
}

variable "lan_cidr" {
  type        = string
  description = "CIDR of the dmz subnet"
  default     = "192.168.100.0/24"
}
