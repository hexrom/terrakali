provider "aws" {
  region = "us-east-1"

  #  assume_role = {
  #    role_arn = "arn:aws:iam::${var.aws_account_id}:role/ADMIN_API_ROLE"
  #  }
}

module "acme" {
  source        = "terraform.prod.acme.com/ACME/acme-tf/aws"
  version       = "1.3.7"
  service_id = var.service_id
  team_id    = var.team_id
}

module "kali-offsec" {
  source          = "../../modules/ec2"
  subnet_id       = module.acme.app_a_subnet_ids[0]
  name            = "kali-vm"
  security_groups = [module.acme.app_sg_id]
  tags            = module.acme.tags

  public_key = local.public_key
  enabled    = true
}

locals {
  public_key = file("${path.module}/keys/pentest-key.pub")
}
