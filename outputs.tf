#output "k8s_config_path" {
#  value = var.k8s_config_path
#}
#
#output "cluster_ca_crt" {
#  value     = rke_cluster.mgmt_cluster.ca_crt
#  sensitive = true
#}
#
#output "cluster_client_cert" {
#  value     = rke_cluster.mgmt_cluster.client_cert
#  sensitive = true
#}
#
#output "cluster_client_key" {
#  value     = rke_cluster.mgmt_cluster.client_key
#  sensitive = true
#}
#
#output "cluster_kube_admin_user" {
#  value     = rke_cluster.mgmt_cluster.kube_admin_user
#  sensitive = true
#}
#
#output "cluster_kube_api_server_url" {
#  value     = rke_cluster.mgmt_cluster.api_server_url
#  sensitive = true
#}
#
#output "cluster_kubeconfig" {
#  value     = rke_cluster.mgmt_cluster.kube_config_yaml
#  sensitive = true
#}

output "rancher_url" {
  value     = "https://${var.rancher_host}"
}

output "admin_token" {
  value     = rancher2_bootstrap.admin.token
  sensitive = true
}

output "admin_password" {
  value     = rancher2_bootstrap.admin.password
  sensitive = true
}

