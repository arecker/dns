locals {
  github_cname  = "arecker.github.io"
}

resource "cloudflare_zone" "zone" {
  zone = "alexrecker.com"
}

resource "cloudflare_record" "apex" {
  zone_id = cloudflare_zone.zone.id
  name    = "@"
  value   = "apex-loadbalancer.netlify.com"
  type    = "CNAME"
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.zone.id
  name    = "www"
  value   = "arecker-blog.netlify.com"
  type    = "CNAME"
  ttl     = 300
}

resource "cloudflare_record" "demo" {
  zone_id = cloudflare_zone.zone.id
  name    = "demo"
  value   = local.github_cname
  type    = "CNAME"
  ttl     = 300
}

resource "cloudflare_record" "archive" {
  zone_id = cloudflare_zone.zone.id
  name    = "archive"
  value   = local.github_cname
  type    = "CNAME"
  ttl     = 300
}

output "blog_nameservers" {
  value = cloudflare_zone.zone.name_servers
}
