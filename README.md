# Fedora CoreOS on Hetzner Cloud

A Terraform module to install [Fedora CoreOS](https://docs.fedoraproject.org/en-US/fedora-coreos/)
via [terraform](https://www.terraform.io) on Hetzner Cloud.

## Use

Include it in your environment config.  Look at `variables.tf` to see what you
want to override.

## Notes

- An `Ignition` `config.yaml` file in the directory with your above `main.tf`
  is sent to the server and processed there by `Butane`.

- Currently there is a
  [bug](https://github.com/coreos/coreos-installer/issues/575) in
  `coreos-installer` or with the use of it in a container that causes it to
  fail on VM's with only 1 cpu/thread.  I built a container you can specify in
  the variables to this module that resolves this.  It's at
  `sedlund/coreos-installer-1cpu`.

## Todo

- Add the option to createIfNotExists a volume to download and uncomrpress the
  the CoreOS image on to that can be sequentially be used by each VM creation
  instead of downloading the image X number of times.

