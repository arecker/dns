#!/usr/bin/env bash

log() {
    echo "generate-config.sh: $1" 1>&2
}

render() {
    cat <<EOF
provider "aws" {
  region     = "us-west-2"
  access_key = "$(cat secrets/aws-access-key-id)"
  secret_key = "$(cat secrets/aws-secret-key)"
}

terraform {
  backend "s3" {
    bucket     = "recker-terraform"
    key        = "dns/${1}.tfstate"
    region     = "us-east-2"
    access_key = "$(cat secrets/aws-access-key-id)"
    secret_key = "$(cat secrets/aws-secret-key)"
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }
}

provider "cloudflare" {
  email   = "$(cat secrets/cloudflare-email)"
  api_key = "$(cat secrets/cloudflare-token)"
}
EOF
}

log "generating ${1}/config.tf"
render "$1"
