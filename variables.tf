variable "auth_url" {
  description = "http://10.10.222.110:5000/v3"
  type        = string
  # auth_url은 OpenStack API에 접근하기 위한 URL입니다. 이 값이 정확해야 인증이 가능합니다.
  # 예시: "http://10.10.222.110:5000/v3"
}

variable "user_name" {
  description = "admin"
  type        = string
  # OpenStack의 사용자 이름입니다. 관리 계정이나 생성된 사용자 계정을 사용하세요.
}

variable "password" {
  description = "test123"
  type        = string
  sensitive   = true
  # OpenStack의 비밀번호입니다. 민감 정보이므로 출력되지 않도록 sensitive 옵션을 사용합니다.
}

variable "tenant_name" {
  description = "admin"
  type        = string
  # 사용자의 프로젝트 또는 테넌트 이름입니다. OpenStack 대시보드에서 확인 가능합니다.
}

variable "region" {
  description = "RegionOne"
  type        = string
  # OpenStack에서 사용할 리전 이름입니다. 예: "RegionOne"
  # 환경에 여러 리전이 있을 경우 반드시 설정이 필요합니다.
}

variable "network_id" {
  description = "956cfe72-ba2d-4cd8-9bbd-2e943fc73450"
  type        = string
  # 사전 생성된 네트워크의 ID입니다.
  # OpenStack 네트워크 대시보드에서 네트워크 ID를 확인 후 입력해야 합니다.
}

variable "image_id" {
  description = "92863027-08bb-48b2-886a-9b3594170762"
  type        = string
  # OpenStack에서 사용할 이미지의 ID입니다.
  # Ubuntu 22.04.5 LTS를 기준으로 작성되어 있으나, 다른 이미지를 사용하려면 적절한 이미지 ID로 교체하세요.
}

variable "volume_size" {
  description = "20" 
  type        = number
  # 생성할 볼륨의 크기입니다. 단위는 GB입니다. 올바른 값 예: 20 (20GB)
}

variable "volume_name" {
  description = "test"
  type        = string
  # 생성할 볼륨의 이름입니다. 의미 있는 이름을 지정하세요.
}

variable "instance_name" {
  description = "test"
  type        = string
  # 생성할 인스턴스의 이름입니다. 예: "my-instance"
}

variable "flavor_name" {
  description = "m1.small"
  type        = string
  # 인스턴스의 사양(Flavor) 이름입니다.
  # 오타가 수정되었습니다. 올바른 이름을 확인 후 입력하세요. 예: "m1.small"
}

variable "key_pair_name" {
  description = "test.inst"
  type        = string
  # 사전에 생성된 SSH 키 페어의 이름입니다.
  # OpenStack에서 키 페어를 생성하고, 그 이름을 입력하세요.
}

variable "security_groups" {
  description = "List of security groups to assign to the instance"
  type        = list(string)
  default     = ["global"]
  # 인스턴스에 할당할 보안 그룹의 목록입니다.
  # 기본적으로 "default" 보안 그룹을 사용하며, 추가 보안 그룹이 필요하다면 목록에 추가하세요.
  # 예: ["default", "web-server"]
}

variable "floating_ip_pool" {
  description = "Floating IP Pool"
  type        = string
  default     = "sharednet1"
  # 플로팅 IP를 할당받을 IP 풀의 이름입니다.
  # 예: "public", "sharednet1"
}
