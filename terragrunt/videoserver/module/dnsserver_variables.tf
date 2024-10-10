variable "dnsserver_image" {
  type        = string
  description = "image of the dnsserver host"
}

variable "dnsserver_flavor" {
  type        = string
  description = "flavor of the dnsserver host"
  default     = "d2-2"
}

variable "dnsserver_userdata" {
  type        = string
  description = "Userdata for the dnsserver virtual machine"
  default     = null
}

variable "inet_cidr" {
  type        = string
  description = "CIDR of the internet subnet"
  default     = "192.42.0.0/16"
}

