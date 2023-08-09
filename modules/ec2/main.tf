locals {
  tags = merge(tomap({ "Name" : var.name }), var.tags)
}

data "aws_ami" "kali_ami_lookup" {
  owners      = ["aws-marketplace"]
  most_recent = true

  filter {
    name   = "name"
    values = ["kali-last-snapshot-amd64*"] # Kali Linux 2023.1
  }
}

resource "aws_instance" "offsec-kali" {
  count           = var.enabled ? 1 : 0
  ami             = data.aws_ami.kali_ami_lookup.id
  instance_type   = "c4.large"
  key_name        = aws_key_pair.offsec-kali[count.index].key_name
  subnet_id       = var.subnet_id
  security_groups = var.security_groups

  root_block_device {
    volume_size = "60"
    tags = local.tags

    delete_on_termination = "true"
  }

  monitoring           = true
  tags                 = local.tags
  iam_instance_profile = var.instance_profile == "" ? "" : var.instance_profile

  user_data = <<EOF
    sudo apt-get update && sudo apt-get install kali-linux-default -y
EOF
}

resource "aws_key_pair" "offsec-kali" {
  count      = var.enabled ? 1 : 0
  key_name   = "pentest-key"
  public_key = var.public_key
}
