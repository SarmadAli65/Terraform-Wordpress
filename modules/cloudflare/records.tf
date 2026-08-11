

resource "cloudflare_dns_record" "name" {
  zone_id = "81ce98300e1fbce137e77e5d35a07d3c"
  type    = "CNAME"
  ttl     = 3600
  name    = "www"
  content = var.domain_name
}

