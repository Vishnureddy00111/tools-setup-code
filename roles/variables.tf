variable "tools" {
  default = {

  }
    vault = {
    port        = 8200
    volume_size = 20
      instance_type = "t3.small"

  }
}

variable "zone_id" {}
default = "Z02665523CCE7X5KKVOH8"

variable "domain_name" {
  default = "vishnureddy.online"
}