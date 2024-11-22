terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"
    }
  }
}

# 인스턴스 생성
resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_name     = var.flavor_name
  key_pair        = var.key_pair_name
  security_groups = var.security_groups

  # 내부 네트워크 연결
  network {
    uuid        = var.network_id
    fixed_ip_v4 = var.fixed_ip # 고정 내부 IP 설정
  }

  # 볼륨 연결
  block_device {
    uuid                  = var.volume_id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }
}


