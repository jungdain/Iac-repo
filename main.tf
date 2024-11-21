terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"  # 최신 버전으로 설정 (예시)
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
 
#볼륨생성
module "volume" {
  source      = "./modules/volume"
  image_id    = var.image_id
  volume_name = var.volume_name
  size        = var.volume_size
}

#인스턴스 생성
module "instance" {
  source          = "./modules/instance"
  instance_name   = var.instance_name 
  flavor_name     = var.flavor_name
  key_pair_name   = var.key_pair_name
  network_id      = var.network_id
  volume_id       = module.volume.volume_id
  security_groups = var.security_groups
}

#플로팅 ip a 생성 
resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = var.floating_ip_pool
}

#플로팅 ip와 인스턴스 연결 
resource "openstack_compute_floatingip_associate_v2" "floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip.address
  instance_id = module.instance.instance_id
}