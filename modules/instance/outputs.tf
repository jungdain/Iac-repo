output "instance_id" {
  description = "The ID of the created instance"
  value       = openstack_compute_instance_v2.instance.id
}
