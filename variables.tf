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
  default     = "39f5b36b-c786-410f-a61f-6120b090a77c"
}

# 이미지 정보
variable "image_id" {
  description = "ID of the image to use for instances"
  type        = string
  default     = "92863027-08bb-48b2-886a-9b3594170762"
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

variable "manager_fixed_ip" {
  description = "Fixed internal IP for the manager instance"
  type        = string
  default     = "192.168.10.10"
}

variable "worker1_fixed_ip" {
  description = "Fixed internal IP for the worker1 instance"
  type        = string
  default     = "192.168.10.11"
}

variable "worker2_fixed_ip" {
  description = "Fixed internal IP for the worker2 instance"
  type        = string
  default     = "192.168.10.12"
}

# 외부 플로팅 IP 정보
variable "manager_floating_ip" {
  description = "Floating IP for the manager instance"
  type        = string
  default     = "211.183.3.100"
}

variable "worker1_floating_ip" {
  description = "Floating IP for the worker1 instance"
  type        = string
  default     = "211.183.3.101"
}

variable "worker2_floating_ip" {
  description = "Floating IP for the worker2 instance"
  type        = string
  default     = "211.183.3.102"
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

# Worker3 관련 변수
variable "worker3_instance_name" {
  description = "Name of the worker3 instance"
  type        = string
  default     = "worker3"
}

variable "worker3_flavor_name" {
  description = "Flavor name for the worker3 instance"
  type        = string
  default     = "db-node" # PostgreSQL 전용 노드 Flavor
}

variable "worker3_fixed_ip" {
  description = "Fixed internal IP for the worker3 instance"
  type        = string
  default     = "192.168.10.13"
}

variable "worker3_floating_ip" {
  description = "Floating IP for the worker3 instance"
  type        = string
  default     = "211.183.3.103"
}

variable "volume_worker3_name" {
  description = "Name of worker3's volume"
  type        = string
  default     = "worker3-volume"
}

variable "volume_worker3_size" {
  description = "Size of worker3's volume in GB"
  type        = number
  default     = 100
}
