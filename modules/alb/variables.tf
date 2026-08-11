variable "vpc_id" {
    type = string
}

variable "alb_subnet_1" {
    type = string
}

variable "alb_subnet_2" {
  type = string
}

variable "instance_ids" {
    type = list(string) 
}

variable "certificate_arn" {
    type = string
}
