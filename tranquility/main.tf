locals {
  github_cname = "arecker.github.io"
}

resource "cloudflare_zone" "zone" {
  zone = "tranquilitydesignsmn.com"
}

module "email" {
  source               = "../modules/privateemail"
  cloudflare_zone_id   = cloudflare_zone.zone.id
  cloudflare_zone_name = cloudflare_zone.zone.zone
}

resource "cloudflare_record" "apex" {
  zone_id = cloudflare_zone.zone.id
  name    = "@"
  value   = local.github_cname
  type    = "CNAME"
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  value   = local.github_cname
  type    = "CNAME"
  ttl     = 300
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.zone.id
  name    = "api"
  value   = "dyjobn5aj21lk.cloudfront.net"
  type    = "CNAME"
  ttl     = 300
}

output "nameservers" {
  value = cloudflare_zone.zone.name_servers
}
