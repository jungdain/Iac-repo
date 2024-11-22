terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"
    }
  }
}

provider "openstack" {
  auth_url    = var.auth_url
  user_name   = var.user_name
  password    = var.password
  tenant_name = var.tenant_name
  region      = var.region
}

# -------------------------
# 볼륨 생성
# -------------------------
module "volumes" {
  source = "./modules/volume"

  for_each = { for inst in var.instances : inst.name => inst }

  volume_name = each.value.volume_name
  size        = each.value.volume_size
  image_id    = var.image_id
}

# -------------------------
# 인스턴스 생성
# -------------------------
module "instances" {
  source = "./modules/instance"

  for_each = { for inst in var.instances : inst.name => inst }

  instance_name   = each.value.name
  flavor_name     = each.value.flavor
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  fixed_ip        = each.value.fixed_ip
  volume_id       = module.volumes[each.key].volume_id
  security_groups = var.security_groups

  # 추가된 인수
  floating_ip     = openstack_networking_floatingip_v2.floating_ips[each.key].address
  floating_ip_pool = var.floating_ip_pool
}

