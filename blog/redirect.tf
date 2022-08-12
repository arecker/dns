# Add a page rule to the domain
resource "cloudflare_page_rule" "foobar" {
  zone_id  = cloudflare_zone.zone.id
  target   = "alexrecker.com/*"
  priority = 1

  actions {
    always_use_https = false

    forwarding_url {
      url         = "https://www.alexrecker.com/$1"
      status_code = "301"
    }
  }
}
