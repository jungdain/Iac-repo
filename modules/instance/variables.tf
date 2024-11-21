variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "flavor_name" {
  description = "Flavor of the instance"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the pre-created key pair"
  type        = string
}

variable "network_id" {
  description = "ID of the network to attach"
  type        = string
}

variable "fixed_ip" {
  description = "Fixed internal IP for the instance"
  type        = string
}

variable "floating_ip" {
  description = "Floating IP to assign to the instance"
  type        = string
}

variable "floating_ip_pool" {
  description = "Floating IP pool for external access"
  type        = string
}

variable "volume_id" {
  description = "ID of the volume to attach"
  type        = string
}

variable "security_groups" {
  description = "List of security groups"
  type        = list(string)
}
