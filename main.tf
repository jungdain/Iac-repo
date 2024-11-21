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

# 볼륨 생성 (3개)
module "volume_manager" {
  source      = "./modules/volume"
  volume_name = "manager-volume"
  size        = 100
  image_id    = var.image_id
}

module "volume_worker1" {
  source      = "./modules/volume"
  volume_name = "worker1-volume"
  size        = 50
  image_id    = var.image_id
}

module "volume_worker2" {
  source      = "./modules/volume"
  volume_name = "worker2-volume"
  size        = 50
  image_id    = var.image_id
}

module "instance_manager" {
  source          = "./modules/instance"
  instance_name   = "manager"
  flavor_name     = "master" # 정확히 OpenStack의 이름과 일치
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  volume_id       = module.volume_manager.volume_id
  security_groups = var.security_groups
}

module "instance_worker1" {
  source          = "./modules/instance"
  instance_name   = "worker1"
  flavor_name     = "worker1" # 정확히 OpenStack의 이름과 일치
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  volume_id       = module.volume_worker1.volume_id
  security_groups = var.security_groups
}

module "instance_worker2" {
  source          = "./modules/instance"
  instance_name   = "worker2"
  flavor_name     = "worker2" # 정확히 OpenStack의 이름과 일치
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  volume_id       = module.volume_worker2.volume_id
  security_groups = var.security_groups
}


# 플로팅 IP 생성 및 연결
resource "openstack_networking_floatingip_v2" "floating_ip_manager" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_manager_assoc" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip_manager.address
  instance_id = module.instance_manager.instance_id
}

resource "openstack_networking_floatingip_v2" "floating_ip_worker1" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker1_assoc" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip_worker1.address
  instance_id = module.instance_worker1.instance_id
}

resource "openstack_networking_floatingip_v2" "floating_ip_worker2" {
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "floating_ip_worker2_assoc" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip_worker2.address
  instance_id = module.instance_worker2.instance_id
}
