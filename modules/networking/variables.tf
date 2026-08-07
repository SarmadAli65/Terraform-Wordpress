variable "availability_zone-1a" {
  type = string
  default = "us-east-1a"
}

variable "availability_zone-1b" {
  type = string
  default = "us-east-1b"
}

variable "subnet_availability_zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}