variable "volume_name" {
  description = "Name of the volume to be created"
  type        = string
}

variable "size" {
  description = "Size of the volume in GB"
  type        = number
}

variable "image_id" {
  description = "ID of the image to use for the volume"
  type        = string
}
