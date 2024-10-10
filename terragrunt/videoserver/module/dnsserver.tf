locals {
    ext_dnsserver_userdata_file = var.dnsserver_userdata == null ? "${path.module}/scripts/default.yml" : var.dnsserver_userdata
}

####################################################################
#
# CREATE INSTANCE for "DNS-Server"
#

data "external" "internet_uuid" {
  program = ["bash", "./fetch_network_uuid.sh"]

  query = {
    network_name = "internet"
  }
}

data "template_file" "userdata_dnsserver" {
  template = "${file("${local.ext_dnsserver_userdata_file}")}"
}

data "template_cloudinit_config" "cloudinitdnsserver" {
  count         = local.ext_dnsserver_userdata_file == null ? 0 : 1
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.userdata_dnsserver.rendered
  }
}

data "openstack_images_image_v2" "dnsserver-image" {
  name        = var.dnsserver_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "dnsserver" {
  name        = "corpdns"
  flavor_name = var.dnsserver_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.dnsserver-image.id
  user_data    = local.ext_dnsserver_userdata_file == null ? null : data.template_cloudinit_config.cloudinitdnsserver[0].rendered

  network {
    uuid = "${data.external.internet_uuid.result.uuid}"
    fixed_ip_v4 = cidrhost(var.inet_cidr,233)
  }

}
