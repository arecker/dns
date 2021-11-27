resource "cloudflare_record" "mx1" {
  zone_id  = var.cloudflare_zone_id
  name     = var.cloudflare_zone_name
  type     = "MX"
  ttl      = "3600"
  proxied  = false
  priority = "1"
  value    = "aspmx.l.google.com"
}

resource "cloudflare_record" "mx2" {
  zone_id  = var.cloudflare_zone_id
  name     = var.cloudflare_zone_name
  type     = "MX"
  ttl      = "3600"
  proxied  = false
  priority = "5"
  value    = "alt1.aspmx.l.google.com"
}

resource "cloudflare_record" "mx3" {
  zone_id  = var.cloudflare_zone_id
  name     = var.cloudflare_zone_name
  type     = "MX"
  ttl      = "3600"
  proxied  = false
  priority = "5"
  value    = "alt2.aspmx.l.google.com"
}

resource "cloudflare_record" "mx4" {
  zone_id  = var.cloudflare_zone_id
  name     = var.cloudflare_zone_name
  type     = "MX"
  ttl      = "3600"
  proxied  = false
  priority = "10"
  value    = "alt3.aspmx.l.google.com"
}

resource "cloudflare_record" "mx5" {
  zone_id  = var.cloudflare_zone_id
  name     = var.cloudflare_zone_name
  type     = "MX"
  ttl      = "3600"
  proxied  = false
  priority = "10"
  value    = "alt4.aspmx.l.google.com"
}
