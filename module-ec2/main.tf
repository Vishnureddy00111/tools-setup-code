resource "aws_security_group" "sg" {
  name        = "${var.tool_name}-sg"
  description = "inbound allow for ${var.tool_name}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.sg_port
    to_port   = var.sg_port
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

tags = {
  name = "${var.tool_name}-sg"
}


resource "aws_instance" "instance" {
  ami           = "data.aws_ami.ami.id"
  instance_type = "var.instance_type"
  vpc_security_group_ids = ["aws_seurity_group.sg.id"]
  tags = {
    name = var.tool_name
  }
}

tags = {
  Name = "{var.tool_name}-sg"
}

# resource "null_resource" "ansible_pull" {}
# provisioner "remote-exec"  {
# }
# connection {
#   type     = "ssh"
#   user     = "ec2-user"
#   password = "DevOps321"
#   host     = "aws_instance.instance.private_ip"
# }
resource "aws_route53_record" "record-public" {
        zone_id = var.zone_id
        name = "${var.tool_name}.${var.domain_name}"
        type = "A"
        ttl  = "30"
        records = "[aws_instace.instance.public_ip]"
}

resource "aws_route53_record" "record-internal" {
  zone_id = var.zone_id
  name = "${var.tool_name}-internal.${var.domain_name}"
  type = "A"
  ttl  = "30"
  records = "[aws_instace.instance.private_ip]"
}