output "instance_id" {
  description = "The ID of the instance"
  value       = openstack_compute_instance_v2.instance.id
}

output "ip_address" {
  description = "The access IP address of the instance"
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
