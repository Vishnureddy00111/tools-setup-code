terraform {
  backend "s3" {
    bucket = "terraform-d81"
    key    = "tools/secret/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "vault" {
  address = "http://vault-internal.vishnureddy.online:8200"
  token = "var.vault_token"
  skip_tls_verify: "true"
}

variable "vault_token" {}

resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "1" }
  description = "RoboShop Dev Secrets"
}


resource "vault_generic_secret" "roboshop-dev" {
  path = "$(vault_mount.roboshop-dev.path}/fronted"

  data_json = <<EOT
{
  "catalogue_url":   "http://catalogue-dev.vishnureddy.online:8080/",
  "cart_url":   "http://cart-dev.vishnureddy.online:8080/",
  "user_url":   "http://user-dev.vishnureddy.online:8080/",
  "shipping_url":   "http://shipping-dev.vishnureddy.online:8080/",
  "payment_url":   "http://payment-dev.vishnureddy.online:8080/"
}
EOT
}