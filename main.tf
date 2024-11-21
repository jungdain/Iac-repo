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

module "volume_manager" {
  source      = "./modules/volume"
  volume_name = var.volume_manager_name
  size        = var.volume_manager_size
  image_id    = var.image_id
}

module "volume_worker1" {
  source      = "./modules/volume"
  volume_name = var.volume_worker1_name
  size        = var.volume_worker1_size
  image_id    = var.image_id
}

module "volume_worker2" {
  source      = "./modules/volume"
  volume_name = var.volume_worker2_name
  size        = var.volume_worker2_size
  image_id    = var.image_id
}

module "volume_worker3" {
  source      = "./modules/volume"
  volume_name = var.volume_worker3_name
  size        = var.volume_worker3_size
  image_id    = var.image_id
}

# -------------------------
# 인스턴스 생성
# -------------------------

module "instance_manager" {
  source          = "./modules/instance"
  instance_name   = var.manager_instance_name
  flavor_name     = var.manager_flavor_name
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  fixed_ip        = var.manager_fixed_ip
  floating_ip     = var.manager_floating_ip
  floating_ip_pool = var.floating_ip_pool
  volume_id       = module.volume_manager.volume_id
  security_groups = var.security_groups
}

module "instance_worker1" {
  source          = "./modules/instance"
  instance_name   = var.worker1_instance_name
  flavor_name     = var.worker1_flavor_name
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  fixed_ip        = var.worker1_fixed_ip
  floating_ip     = var.worker1_floating_ip
  floating_ip_pool = var.floating_ip_pool
  volume_id       = module.volume_worker1.volume_id
  security_groups = var.security_groups
}

module "instance_worker2" {
  source          = "./modules/instance"
  instance_name   = var.worker2_instance_name
  flavor_name     = var.worker2_flavor_name
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  fixed_ip        = var.worker2_fixed_ip
  floating_ip     = var.worker2_floating_ip
  floating_ip_pool = var.floating_ip_pool
  volume_id       = module.volume_worker2.volume_id
  security_groups = var.security_groups
}

module "instance_worker3" {
  source          = "./modules/instance"
  instance_name   = var.worker3_instance_name
  flavor_name     = var.worker3_flavor_name
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  fixed_ip        = var.worker3_fixed_ip
  floating_ip     = var.worker3_floating_ip
  floating_ip_pool = var.floating_ip_pool
  volume_id       = module.volume_worker3.volume_id
  security_groups = var.security_groups
}

# -------------------------
# 플로팅 IP 생성 및 연결
# -------------------------

resource "openstack_networking_floatingip_v2" "floating_ip_manager" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_manager_assoc" {
  floating_ip = var.manager_floating_ip
  instance_id = module.instance_manager.instance_id
}

resource "openstack_networking_floatingip_v2" "floating_ip_worker1" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker1_assoc" {
  floating_ip = var.worker1_floating_ip
  instance_id = module.instance_worker1.instance_id
}

resource "openstack_networking_floatingip_v2" "floating_ip_worker2" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker2_assoc" {
  floating_ip = var.worker2_floating_ip
  instance_id = module.instance_worker2.instance_id
}

resource "openstack_networking_floatingip_v2" "floating_ip_worker3" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker3_assoc" {
  floating_ip = var.worker3_floating_ip
  instance_id = module.instance_worker3.instance_id
}
