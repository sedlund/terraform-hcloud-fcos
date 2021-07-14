terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud",
      version = ">= 1.27.2"
    }
  }
  required_version = ">= 1.0.1"
}
