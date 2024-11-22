terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"
    }
  }
}

resource "openstack_compute_instance_v2" "instance" {
  name        = var.instance_name
  flavor_name = var.flavor_name
  key_pair    = var.key_pair_name

  network {
    uuid        = var.network_id
    fixed_ip_v4 = var.fixed_ip
  }

  security_groups = var.security_groups

  block_device {
    uuid                  = var.volume_id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }

  image_id = var.image_id

  # Floating IP 설정 (필요할 경우 사용)
  access_ip_v4 = var.floating_ip
}
