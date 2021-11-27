locals {
  github_cname = "arecker.github.io"
}

resource "cloudflare_zone" "zone" {
  zone = "bobrosssearch.com"
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

output "nameservers" {
  value = cloudflare_zone.zone.name_servers
}
