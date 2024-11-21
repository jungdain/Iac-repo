output "instance_id" {
  description = "ID of the created instance"
  value       = module.instance.instance_id
}

output "floating_ip" {
  description = "Floating IP address of the instance"
  value       = openstack_networking_floatingip_v2.floating_ip.address
}