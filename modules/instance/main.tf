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

# 플로팅 IP 생성
resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = var.floating_ip_pool
}

# 플로팅 IP와 인스턴스 연결
resource "openstack_compute_floatingip_associate_v2" "floating_ip_association" {
  floating_ip = var.floating_ip # 명시적으로 플로팅 IP 설정
  instance_id = openstack_compute_instance_v2.instance.id
}

# Worker3 전용 플로팅 IP 생성
resource "openstack_networking_floatingip_v2" "worker3_floating_ip" {
  pool = var.floating_ip_pool
}

# Worker3 플로팅 IP 연결
resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker3_assoc" {
  floating_ip = openstack_networking_floatingip_v2.worker3_floating_ip.address
  instance_id = openstack_compute_instance_v2.instance.id
}

# 출력 변수
output "instance_id" {
  description = "ID of the created instance"
  value       = openstack_compute_instance_v2.instance.id
}

output "floating_ip" {
  description = "Floating IP of the created instance"
  value       = openstack_networking_floatingip_v2.floating_ip.address
}
