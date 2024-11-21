terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"
    }
  }
}

provider "openstack" {
  alias = "instance" # 필요한 경우 추가. 상위 Provider를 상속받으면 생략 가능.
}


resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name
  security_groups = var.security_groups

  network {
    uuid = var.network_id
  }

  block_device {
    uuid                  = var.volume_id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }
}

output "instance_id" {
  value = openstack_compute_instance_v2.instance.id
}