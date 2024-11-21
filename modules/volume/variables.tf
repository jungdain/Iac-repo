variable "volume_name" {
  description = "Name of the volume to be created"
  type        = string
  default     = "test"  # 최상위 variables.tf에서의 기본값을 반영
}

variable "size" {
  description = "Size of the volume in GB"
  type        = number
  default     = 20  # 최상위 variables.tf에서 volume_size 기본값 반영
}

variable "image_id" {
  description = "ID of the image to use for the volume"
  type        = string
  default     = "92863027-08bb-48b2-886a-9b3594170762"  # 최상위 variables.tf에서 image_id 기본값 반영
}