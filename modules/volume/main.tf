terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.0"
    }
  }
}



resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.volume_name
  size        = var.size
  image_id    = var.image_id
  description = ""
}

output "volume_id" {
  value = openstack_blockstorage_volume_v3.volume.id
}