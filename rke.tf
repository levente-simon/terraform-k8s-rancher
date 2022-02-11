variable "module_depends_on" {
  type    = any
  default = []
}

resource "rke_cluster" "mgmt_cluster" {
  depends_on = [ var.module_depends_on ]

  cluster_name = "rancher-management"

  dynamic "nodes" {
    for_each  = var.cluster_hosts
    content {
      address = nodes.value.ip
      user    = var.os_user
      role    = nodes.value.roles
      ssh_key = var.ssh_private_key
    }
  }
  upgrade_strategy {
      drain                  = true
      max_unavailable_worker = "20%"
  }
}

resource "local_file" "kube_config" {
    sensitive_content = rke_cluster.mgmt_cluster.kube_config_yaml
    filename          = var.k8s_config_path
    file_permission   = "0600"
}

