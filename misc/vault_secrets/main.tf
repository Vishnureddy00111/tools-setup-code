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

resource "vault_generic_secret" "roboshop-dev" {
  path = "roboshop-dev/fronted"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}