variable "floating_pool" {
  type        = string
  description = "Pool for floating ip-addresses"
}

variable "fw_userdata" {
  type        = string
  description = "Userdata for the firewall virtual machine"
  default     = null
}

variable "mgmt_userdata" {
  type        = string
  description = "Userdata for the management host"
  default     = null
}

variable "ext_dns_userdata" {
  type        = string
  description = "variables for the userdata template"
  default     = null
}

variable "ext_router" {
  type        = string
  description = "name of the external router"
}

variable "inet_cidr" {
  type        = string
  description = "CIDR of the internet subnet"
  default     = "192.42.0.0/16"
}

variable "inetdns_flavor" {
  type        = string
  description = "flavor of the internet dns server"
  default     = "m1.small"
}

variable "inetdns_image" {
  type        = string
  description = "image of he internet dns server"
}

variable "sshkey" {
  type        = string
  description = "ssh-key for administration"
}

variable "inetfw_image" {
  type        = string
  description = "image of the internet firewall"
}

variable "inetfw_flavor" {
  type        = string
  description = "flavor of the internet firewall"
  default     = "m1.small"
}

variable "mgmt_image" {
  type        = string
  description = "image of the management host"
}

variable "mgmt_flavor" {
  type        = string
  description = "flavor of the management host"
  default     = "m1.small"
}

variable "inet_dns" {
  type        = list(string)
  description = "dns servers to configure for the internet"
  default     = ["1.1.1.1","8.8.8.8"] 
}

variable "lan_cidr" {
  type        = string
  description = "CIDR of the lan subnet"
  default     = "192.168.100.0/24"
}

variable "dmz_cidr" {
  type        = string
  description = "CIDR of the dmz subnet"
  default     = "172.17.100.0/24"
}

