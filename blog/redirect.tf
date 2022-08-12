resource "cloudflare_page_rule" "foobar" {
  zone_id  = cloudflare_zone.zone.id
  target   = "alexrecker.com/*"
  priority = 100

  actions {
    always_use_https = false

    forwarding_url {
      url         = "https://www.alexrecker.com/$1"
      status_code = "301"
    }
  }
}

resource "cloudflare_page_rule" "minify" {
  zone_id  = cloudflare_zone.zone.id
  target   = "https://www.alexrecker.com/*"
  priority = 1

  actions {
    minify {
      html = "on"
      css  = "on"
      js   = "on"
    }
  }
}
