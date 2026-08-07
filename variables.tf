variable "region" {
    type = string
    default = "us-east-1"
}

### Wordpress admin
variable "admin_password_wordpress" {
  type = string
  sensitive = true
}

variable "admin_username_wordpress" {
  type = string
}

variable "admin_email_wordpress" {
  type = string
}

### RDS
variable "dv_password" {
  type = string
  sensitive = true
}
