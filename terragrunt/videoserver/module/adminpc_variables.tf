variable "adminpc_image" {
  type        = string
  description = "image of the adminpc host"
}

variable "adminpc_flavor" {
  type        = string
  description = "flavor of the adminpc host"
  default     = "m1.small"
}

variable "adminpc_userdata" {
  type        = string
  description = "Userdata for the adminpc virtual machine"
  default     = null
}
