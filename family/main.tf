resource "cloudflare_zone" "zone" {
  zone = "reckerfamily.com"
}

resource "cloudflare_record" "cookbook" {
  zone_id         = cloudflare_zone.zone.id
  name            = "cookbook"
  type            = "CNAME"
  proxied         = true
  ttl             = "1"
  value           = "readthedocs.io"
  allow_overwrite = true
}

module "email" {
  source               = "../modules/gmail"
  cloudflare_zone_id   = cloudflare_zone.zone.id
  cloudflare_zone_name = cloudflare_zone.zone.zone
}

output "nameservers" {
  value = cloudflare_zone.zone.name_servers
}

