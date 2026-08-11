resource "aws_acm_certificate" "certification" {
  domain_name       = "*.sarmadcloud.work"
  validation_method = "DNS"

  lifecycle {
    prevent_destroy = true
  }
}



