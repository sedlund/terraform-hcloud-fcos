provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_server" "instance" {
  name   = var.hcloud_server_name
  labels = { "os" = "coreos" }

  server_type = var.hcloud_server_type
  datacenter  = var.hcloud_server_datacenter

  # Image is ignored, as we boot into rescue mode, but is a required field
  image    = "fedora-34"
  rescue   = "linux64"
  ssh_keys = var.ssh_public_key_name
  network  = (var.network != "" ? var.network : null)

  connection {
    host    = hcloud_server.instance.ipv4_address
    timeout = "5m"
    agent   = true
    user    = "root" # Root is the available user in rescue mode 
  }

  # Copy config.yaml
  provisioner "file" {
    source      = var.ignition_yaml
    destination = "/root/config.yaml"
  }

  # Install Fedora CoreOS in rescue mode
  provisioner "remote-exec" {
    inline = [
      "set -x",
      "update-alternatives --set iptables /usr/sbin/iptables-legacy",
      "update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy",
      "apt install -y docker.io",
      "apt clean",
      "docker run -it --rm -v /root:/pwd -w /pwd quay.io/coreos/butane:${var.tools_butane_version} -o config.ign config.yaml",
      "docker run --privileged --rm -v /dev:/dev -v /run/udev:/run/udev -v /root:/data -w /data quay.io/coreos/coreos-installer:release install /dev/sda -p qemu -i config.ign",
      # Force a sync otherwise install sometimes fails?
      "sync",
      # Exit rescue mode and boot into coreos
      "reboot",
    ]
  }

  # Configure CoreOS after installation
  provisioner "remote-exec" {
    connection {
      host    = hcloud_server.instance.ipv4_address
      timeout = "2m"
      agent   = true
      # This user is configured in config.yaml
      user = "core"
    }

    inline = [
      "sudo hostnamectl set-hostname ${hcloud_server.instance.name}"
    ]
  }
}
