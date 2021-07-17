# Input variable definitions

variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "hcloud_server_type" {
  description = "Server type name, see `hcloud server-type list`. Requires at least 2GB of RAM"
  type        = string
  default     = "cx11"
}

variable "hcloud_server_datacenter" {
  description = "Desired datacenter location name, lookup via `hcloud datacenter list`"
  type        = string
  default     = "fsn1-dc14"
}

variable "hcloud_server_name" {
  description = "Name of the server"
  type        = string
  default     = "coreos"
}

variable "ssh_key_name" {
  description = "Name of your public key to identify at Hetzner Cloud portal"
  type        = list(string)
  default     = ["My-SSH-Key"]
}

/* variable "network" { */
/*   description = "(Optional) Network the server should be attached to on creation. (Can be specified multiple times)" */
/*   type        = map(any) */
/*   default     = [null] */
/* } */

variable "butane" {
  description = "See https://quay.io/repository/coreos/butane?tab=tags for available versions"
  type        = string
  default     = "quay.io/coreos/butane:release"
}

variable "coreos-installer" {
  description = "See https://quay.io/repository/coreos/butane?tab=tags for available versions"
  type        = string
  default     = "quay.io/coreos/butane:release"
}

variable "ignition_yaml" {
  description = "Ignition configuration that will be passed to butane"
  type        = string
  default     = "config.yaml"
}
