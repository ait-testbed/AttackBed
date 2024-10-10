locals {
    ext_webcam_userdata_file = var.webcam_userdata == null ? "${path.module}/scripts/default.yml" : var.webcam_userdata
}

####################################################################
#
# CREATE INSTANCE for "Webcam-Server"
#

data "template_file" "userdata_webcam" {
  template = "${file("${local.ext_webcam_userdata_file}")}"
}

data "template_cloudinit_config" "cloudinitwebcam" {
  count         = local.ext_webcam_userdata_file == null ? 0 : 1
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.userdata_webcam.rendered
  }
}

data "openstack_images_image_v2" "webcam-image" {
  name        = var.webcam_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "webcam" {
  name        = "webcam"
  flavor_name = var.webcam_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.webcam-image.id
  user_data    = local.ext_webcam_userdata_file == null ? null : data.template_cloudinit_config.cloudinitwebcam[0].rendered

  network {
    uuid = "${data.external.dmz_uuid.result.uuid}"
    fixed_ip_v4 = cidrhost(var.dmz_cidr,80)
  }

}
