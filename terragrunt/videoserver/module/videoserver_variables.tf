variable "videoserver_image" {
  type        = string
  description = "image of the videoserver host"
}

variable "videoserver_flavor" {
  type        = string
  description = "flavor of the videoserver host"
  default     = "d2-2"
}

variable "videoserver_userdata" {
  type        = string
  description = "Userdata for the videoserver virtual machine"
  default     = null
}


