output "instances_with_floating_ips" {
  value = {
    for name in keys(openstack_compute_floatingip_associate_v2.floating_ip_assoc) : name => {
      name        = name
      floating_ip = openstack_compute_floatingip_associate_v2.floating_ip_assoc[name].floating_ip
    }
  }
}
