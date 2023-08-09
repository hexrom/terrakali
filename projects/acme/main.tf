# Configure the AWS provider with the desired region.
provider "aws" {
  region = "us-east-1"

  # Assume an IAM role for enhanced permissions (commented out).
  #  assume_role = {
  #    role_arn = "arn:aws:iam::${var.aws_account_id}:role/ADMIN_API_ROLE"
  #  }
}

# Define the ACME module for provisioning resources.
module "acme" {
  source        = "terraform.prod.acme.com/ACME/acme-tf/aws"
  version       = "1.3.7"
  service_id = var.service_id
  team_id    = var.team_id
}

# Instantiate the Kali Offsec module to create an EC2 instance.
module "kali-offsec" {
  source          = "../../modules/ec2"
  subnet_id       = module.acme.app_a_subnet_ids[0]
  name            = "kali-vm"
  security_groups = [module.acme.app_sg_id]
  tags            = module.acme.tags

  public_key = local.public_key
  enabled    = true
}

# Define local variables including the public key file path.
locals {
  public_key = file("${path.module}/keys/pentest-key.pub")
}
