output "floating_ips" {
  description = "Floating IPs of all instances"
  value       = { for name, assoc in openstack_compute_floatingip_associate_v2.floating_ip_assoc : name => assoc.floating_ip }
}
