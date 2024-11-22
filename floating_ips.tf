# 플로팅 IP 생성
resource "openstack_networking_floatingip_v2" "floating_ips" {
  for_each = { for inst in var.instances : inst.name => inst if inst.floating_ip == "" }

  pool = var.floating_ip_pool
}

# 플로팅 IP와 인스턴스 연결
resource "openstack_compute_floatingip_associate_v2" "floating_ip_assoc" {
  for_each = { for inst in var.instances : inst.name => inst }

  floating_ip = each.value.floating_ip != "" ? each.value.floating_ip : openstack_networking_floatingip_v2.floating_ips[each.key].address
  instance_id = module.instances[each.key].instance_id
}
