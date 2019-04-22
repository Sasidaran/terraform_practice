variable "region" {
  default = "ap-south-1"
}

variable "ami_id" {
  description = "sample_ami"
  default = "ami-54d2a63b"
}

variable "amis" {
  type = "map"
  default = {
    "ap-south-1" = "ami-54d2a63b"
  }
}

