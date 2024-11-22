variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "flavor_name" {
  description = "Flavor name for the instance"
  type        = string
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "network_id" {
  description = "Network ID to attach the instance"
  type        = string
}

variable "fixed_ip" {
  description = "Fixed IP address for the instance"
  type        = string
}

variable "volume_id" {
  description = "Volume ID to attach to the instance"
  type        = string
}

variable "security_groups" {
  description = "List of security groups"
  type        = list(string)
}

variable "floating_ip_pool" {
  description = "Floating IP pool to use"
  type        = string
}

variable "floating_ip" {
  description = "Floating IP to assign to the instance"
  type        = string
  default     = null
}

variable "image_id" {
  description = "Image ID to use for the instance"
  type        = string
}
