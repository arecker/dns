resource "cloudflare_zone" "zone" {
  zone = "astuaryart.com"
}

locals {
  verify = "ebtl774twac5c3edhn2e"
  ips = [
    "198.185.159.145",
    "198.185.159.144",
    "198.49.23.144",
    "198.49.23.145"
  ]
}

resource "cloudflare_record" "apex" {
  count   = length(local.ips)
  zone_id = cloudflare_zone.zone.id
  name    = cloudflare_zone.zone.zone
  type    = "A"
  proxied = false
  ttl     = "900"
  value   = local.ips[count.index]
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  type    = "CNAME"
  proxied = false
  ttl     = "900"
  value   = "ext-cust.squarespace.com"
}

resource "cloudflare_record" "verify" {
  zone_id = cloudflare_zone.zone.id
  name    = local.verify
  type    = "CNAME"
  proxied = false
  ttl     = "900"
  value   = "verify.squarespace.com"
}

output "nameservers" {
  value = cloudflare_zone.zone.name_servers
}
