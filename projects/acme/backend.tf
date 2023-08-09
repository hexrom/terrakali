# Configure Terraform to use a remote backend for state management.
terraform {
  backend "remote" {
    hostname     = "terraform.prod.acme.com"
    organization = "ACME"

    workspaces {
      prefix = "kali-vm-"
    }
  }
}
