data "rancher2_cluster" "local" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  name       = "local"
}

resource "time_sleep" "wait_60_seconds_2" {
  depends_on = [ rancher2_bootstrap.admin ]
  create_duration = "60s"
}

################################################################
##
##       Catalogs
##
################################################################

resource "rancher2_catalog_v2" "bitnami" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "bitnami"
  url        = "https://charts.bitnami.com/bitnami"
}