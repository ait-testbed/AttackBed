variable "webcam_image" {
  type        = string
  description = "image of the webcam host"
}

variable "webcam_flavor" {
  type        = string
  description = "flavor of the webcam host"
  default     = "d2-2"
}

variable "webcam_userdata" {
  type        = string
  description = "Userdata for the webcam virtual machine"
  default     = null
}



