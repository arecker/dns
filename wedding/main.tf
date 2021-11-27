resource "cloudflare_zone" "zone" {
  zone = "alexandmarissa.com"
}

module "email" {
  source               = "../modules/privateemail"
  cloudflare_zone_id   = cloudflare_zone.zone.id
  cloudflare_zone_name = cloudflare_zone.zone.zone
}

resource "cloudflare_record" "www" {
  zone_id         = cloudflare_zone.zone.id
  name            = "www"
  type            = "CNAME"
  proxied         = true
  ttl             = "1"
  value           = "arecker.github.io"
  allow_overwrite = true
}

resource "cloudflare_record" "apex" {
  zone_id         = cloudflare_zone.zone.id
  name            = cloudflare_zone.zone.zone
  type            = "CNAME"
  proxied         = true
  ttl             = "1"
  value           = format("www.%s", cloudflare_zone.zone.zone)
  allow_overwrite = true
}
