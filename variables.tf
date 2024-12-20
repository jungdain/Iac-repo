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

variable "network_id" {
  description = "Network ID for instances"
  type        = string
  default     = "39f5b36b-c786-410f-a61f-6120b090a77c"
}

variable "image_id" {
  description = "Image ID to use for instances"
  type        = string
  default     = "92863027-08bb-48b2-886a-9b3594170762"
}

variable "floating_ip_pool" {
  description = "Floating IP Pool for external access"
  type        = string
  default     = "sharednet1"
}

variable "key_pair_name" {
  description = "SSH Key Pair Name"
  type        = string
  default     = "test-inst"
}

variable "security_groups" {
  description = "Security groups to assign to instances"
  type        = list(string)
  default     = ["global"]
}

# 올바르게 정의된 instances 변수
variable "instances" {
  description = "List of instances with details"
  type = list(object({
    name        = string
    flavor      = string
    fixed_ip    = string
    floating_ip = string
    volume_name = string
    volume_size = number
    volume_id   = string
  }))
  default = [
    {
      name        = "master"
      flavor      = "master"
      fixed_ip    = "192.168.10.10"
      floating_ip = ""  # Auto-allocate
      volume_name = "master-volume"
      volume_size = 100
      volume_id   = ""  # 기본값으로 빈 문자열 설정
    },
    {
      name        = "worker1"
      flavor      = "worker1"
      fixed_ip    = "192.168.10.11"
      floating_ip = ""  # Auto-allocate
      volume_name = "worker1-volume"
      volume_size = 50
      volume_id   = ""  # 빈 문자열 추가
    },
    {
      name        = "worker2"
      flavor      = "worker2"
      fixed_ip    = "192.168.10.12"
      floating_ip = ""  # Auto-allocate
      volume_name = "worker2-volume"
      volume_size = 50
      volume_id   = ""  # 빈 문자열 추가
    },
    {
      name        = "worker3"
      flavor      = "worker3"
      fixed_ip    = "192.168.10.13"
      floating_ip = ""  # Auto-allocate
      volume_name = "worker3-volume"
      volume_size = 50
      volume_id   = ""  # 빈 문자열 추가
    }
  ]
}
