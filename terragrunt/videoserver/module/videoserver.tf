locals {
    ext_videoserver_userdata_file = var.videoserver_userdata == null ? "${path.module}/scripts/default.yml" : var.videoserver_userdata
}

####################################################################
#
# CREATE INSTANCE for "VIDEOSERVER"
#

data "external" "dmz_uuid" {
  program = ["bash", "./fetch_network_uuid.sh"]

  query = {
    network_name = "dmz"
  }
}

data "template_file" "userdata_videoserver" {
  template = "${file("${local.ext_videoserver_userdata_file}")}"
}

data "template_cloudinit_config" "cloudinitvideoserver" {
  count         = local.ext_videoserver_userdata_file == null ? 0 : 1
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.userdata_videoserver.rendered
  }
}

data "openstack_images_image_v2" "videoserver-image" {
  name        = var.videoserver_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "videoserver" {
  name        = "videoserver"
  flavor_name = var.videoserver_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.videoserver-image.id
  user_data    = local.ext_videoserver_userdata_file == null ? null : data.template_cloudinit_config.cloudinitvideoserver[0].rendered

  network {
    uuid = "${data.external.dmz_uuid.result.uuid}"
    fixed_ip_v4 = cidrhost(var.dmz_cidr,121)
  }

}
