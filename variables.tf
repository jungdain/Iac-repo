# OpenStack 인증 정보
variable "auth_url" {
  description = "OpenStack Authentication URL"
  type        = string
  default     = "http://10.10.222.110:5000/v3"
}

variable "user_name" {
  description = "OpenStack Username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "OpenStack Password"
  type        = string
  sensitive   = true
  default     = "test123"
}

variable "tenant_name" {
  description = "OpenStack Project (Tenant) Name"
  type        = string
  default     = "admin"
}

variable "region" {
  description = "OpenStack Region"
  type        = string
  default     = "RegionOne"
}

# 네트워크 정보
variable "network_id" {
  description = "ID of the pre-created network"
  type        = string
  default     = "956cfe72-ba2d-4cd8-9bbd-2e943fc73450"
}

# 이미지 정보
variable "image_id" {
  description = "ID of the image to use for instances"
  type        = string
  default     = "92863027-08bb-48b2-886a-9b3594170762"
}

# SSH 키 및 보안 그룹
variable "key_pair_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "test-inst"
}

variable "security_groups" {
  description = "List of security groups to assign to instances"
  type        = list(string)
  default     = ["global"]
}

variable "floating_ip_pool" {
  description = "Floating IP Pool"
  type        = string
  default     = "sharednet1"
}

# 볼륨 정보
variable "volume_manager_name" {
  description = "Name of the manager's volume"
  type        = string
  default     = "manager-volume"
}

variable "volume_manager_size" {
  description = "Size of the manager's volume in GB"
  type        = number
  default     = 100
}

variable "volume_worker1_name" {
  description = "Name of worker1's volume"
  type        = string
  default     = "worker1-volume"
}

variable "volume_worker1_size" {
  description = "Size of worker1's volume in GB"
  type        = number
  default     = 50
}

variable "volume_worker2_name" {
  description = "Name of worker2's volume"
  type        = string
  default     = "worker2-volume"
}

variable "volume_worker2_size" {
  description = "Size of worker2's volume in GB"
  type        = number
  default     = 50
}

# 인스턴스 정보
variable "manager_instance_name" {
  description = "Name of the manager instance"
  type        = string
  default     = "manager"
}

variable "manager_flavor_name" {
  description = "Flavor name for the manager instance"
  type        = string
  default     = "master"
}

variable "worker1_instance_name" {
  description = "Name of the worker1 instance"
  type        = string
  default     = "worker1"
}

variable "worker1_flavor_name" {
  description = "Flavor name for the worker1 instance"
  type        = string
  default     = "worker1"
}

variable "worker2_instance_name" {
  description = "Name of the worker2 instance"
  type        = string
  default     = "worker2"
}

variable "worker2_flavor_name" {
  description = "Flavor name for the worker2 instance"
  type        = string
  default     = "worker2"
}
