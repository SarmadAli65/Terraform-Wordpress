variable "password" {
    type = string
    sensitive = true
}

variable "subnets_id" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}
