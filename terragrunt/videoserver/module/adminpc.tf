locals {
    ext_adminpc_userdata_file = var.adminpc_userdata == null ? "${path.module}/scripts/default.yml" : var.adminpc_userdata
}

####################################################################
#
# CREATE INSTANCE for "ADMIN"
#

data "external" "lan_uuid" {
  program = ["bash", "./fetch_network_uuid.sh"]

  query = {
    network_name = "lan"
  }
}

data "template_file" "userdata_adminpc" {
  template = "${file("${local.ext_adminpc_userdata_file}")}"
}

data "template_cloudinit_config" "cloudinitadminpc" {
  count         = local.ext_adminpc_userdata_file == null ? 0 : 1
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.userdata_adminpc.rendered
  }
}

data "openstack_images_image_v2" "adminpc-image" {
  name        = var.adminpc_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "adminpc" {
  name        = "adminpc1"
  flavor_name = var.adminpc_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.adminpc-image.id
  user_data    = local.ext_adminpc_userdata_file == null ? null : data.template_cloudinit_config.cloudinitadminpc[0].rendered

  network {
    uuid ="${data.external.lan_uuid.result.uuid}"
    fixed_ip_v4 = cidrhost(var.lan_cidr,222)
  }

}
