# 플로팅 IP 생성
resource "openstack_networking_floatingip_v2" "floating_ips" {
  for_each = { for inst in var.instances : inst.name => inst if inst.floating_ip == "" }
  pool     = var.floating_ip_pool
}

# 플로팅 IP와 인스턴스 연결
resource "openstack_compute_floatingip_associate_v2" "floating_ip_assoc" {
  for_each    = { for inst in var.instances : inst.name => inst }
  floating_ip = each.value.floating_ip != "" ? each.value.floating_ip : openstack_networking_floatingip_v2.floating_ips[each.key].address
  instance_id = module.instances[each.key].instance_id
}

# SSH 키 복사 작업
resource "null_resource" "copy_ssh_key" {
  for_each = { for inst in var.instances : inst.name => inst }

  depends_on = [
    openstack_compute_floatingip_associate_v2.floating_ip_assoc
  ]

  provisioner "local-exec" {
    command = <<EOT
      for i in {1..5}; do
        ansible all -i "${openstack_compute_floatingip_associate_v2.floating_ip_assoc[each.key].floating_ip}," \
        -u ubuntu --private-key /root/.ssh/id_rsa \
        -m authorized_key \
        -a 'user=ubuntu state=present key="$(cat /root/.ssh/id_rsa.pub)"' && break || sleep 30;
      done
    EOT
  }
}

# Ansible 인벤토리 파일 생성
resource "local_file" "ansible_inventory" {
  depends_on = [openstack_compute_floatingip_associate_v2.floating_ip_assoc]

  content = <<EOT
[master]
${openstack_compute_floatingip_associate_v2.floating_ip_assoc["master"].floating_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/id_rsa

[workers]
${openstack_compute_floatingip_associate_v2.floating_ip_assoc["worker1"].floating_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/id_rsa
${openstack_compute_floatingip_associate_v2.floating_ip_assoc["worker2"].floating_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/id_rsa
${openstack_compute_floatingip_associate_v2.floating_ip_assoc["worker3"].floating_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/id_rsa
EOT

  filename = "${path.module}/inventory/hosts"
}

# Ansible Playbook 실행
resource "null_resource" "run_ansible_playbooks" {
  depends_on = [local_file.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      LOG_DIR="${path.module}/log"
      mkdir -p $LOG_DIR
      TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
      LOG_FILE="$LOG_DIR/ansible_execution_$TIMESTAMP.log"
      for i in {1..3}; do
        ansible-playbook -i ${path.module}/inventory/hosts ${path.module}/copy_ssh_key.yml \
          --log-file=$LOG_FILE &&
        ansible-playbook -i ${path.module}/inventory/hosts ${path.module}/install_docker.yml \
          --log-file=$LOG_FILE &&
        ansible-playbook -i ${path.module}/inventory/hosts ${path.module}/init_swarm.yml \
          --log-file=$LOG_FILE &&
        ansible-playbook -i ${path.module}/inventory/hosts ${path.module}/deploy_services.yml \
          --log-file=$LOG_FILE && break || sleep 30;
      done
    EOT
  }
}
