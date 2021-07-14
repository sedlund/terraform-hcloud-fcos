# Fedora CoreOS on Hetzner Cloud

A Terraform module to install [Fedora CoreOS](https://docs.fedoraproject.org/en-US/fedora-coreos/)
via [terraform](https://www.terraform.io) on Hetzner Cloud.

## Use

Include it in your environment config.

`main.tf`
```
module "hcloud_fcos" {
  source = "git::https://github.com/sedlund/terraform-hcloud-fcos.git?ref=v0.0.1"
  
  # Required
  hcloud_token             = "your api token here"

  # Defaults
  hcloud_server_type       = "cx21"
  hcloud_server_datacenter = "fsn1-dc14"
  hcloud_server_name       = "www1"
  ssh_public_key_name      = "My-SSH-Key"
  tools_butane_version     = "release"
  ignition_yaml            = "config.yaml" 
}
```

## Notes

An `Ignition` `config.yaml` file in the directory with your above `main.tf` is
sent to the server and processed there by `Butane`.

Currently a VM with at least 4GB is required to complete the install for the
CoreOS image and docker to fit in memory.  After install you can use `hcloud
server change-type` to reduce the size if required.

If you wanted to to install on the smallest VM's on Hetzner, it may be possible
to create and attach a volume to `/var/lib/docker` before installing docker and
running `coreos-installer` to reduce the required memory usage.  I haven't
tried this yet.

