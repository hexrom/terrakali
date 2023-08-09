terraform {
  backend "remote" {
    hostname     = "terraform.prod.acme.com"
    organization = "ACME"

    workspaces {
      prefix = "kali-vm-"
    }
  }
}
