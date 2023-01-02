data "rancher2_cluster" "local" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  name       = "local"
}

resource "rancher2_catalog_v2" "bitnami" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "bitnami"
  url        = "https://charts.bitnami.com/bitnami"
}