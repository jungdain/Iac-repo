output "manager_instance_id" {
  value = module.instance_manager.instance_id
}

output "worker1_instance_id" {
  value = module.instance_worker1.instance_id
}

output "worker2_instance_id" {
  value = module.instance_worker2.instance_id
}

output "manager_floating_ip" {
  value = openstack_networking_floatingip_v2.floating_ip_manager.address
}

output "worker1_floating_ip" {
  value = openstack_networking_floatingip_v2.floating_ip_worker1.address
}

output "worker2_floating_ip" {
  value = openstack_networking_floatingip_v2.floating_ip_worker2.address
}
