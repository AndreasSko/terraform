resource "openstack_compute_instance_v2" "proxy" {
  name            = "proxy.galaxyproject.eu"
  image_name      = "CentOS 7"
  flavor_name     = "m1.small"
  key_pair        = "cloud2"
  security_groups = ["egress", "ufr-ssh", "public-web"]

  network {
    name = "public"
  }

}

resource "aws_route53_record" "proxy" {
  zone_id = "${var.zone_galaxyproject_eu}"
  name    = "proxy.galaxyproject.eu"
  type    = "A"
  ttl     = "300"
  records = ["${openstack_compute_instance_v2.proxy.access_ip_v4}"]
}