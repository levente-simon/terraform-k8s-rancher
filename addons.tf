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

resource "rancher2_catalog_v2" "metallb" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "metallb"
  url        = "https://metallb.github.io/metallb"
}

resource "rancher2_catalog_v2" "bitnami" {
  depends_on = [ rancher2_bootstrap.admin ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "bitnami"
  url        = "https://charts.bitnami.com/bitnami"
}

################################################################
##
##       Longhorn
##
################################################################

resource "rancher2_app_v2" "longhorn" {
  depends_on = [ time_sleep.wait_60_seconds_2 ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "longhorn"
  repo_name  = "rancher-charts"
  chart_name = "longhorn"
  namespace  = "longhorn-system"
  values     = format(file("${path.module}/etc/longhorn-config.yaml"), var.longhorn_data_path)
}

################################################################
##
##       Metallb
##
################################################################

resource "rancher2_app_v2" "metallb" {
  depends_on = [ rancher2_catalog_v2.metallb,
                 time_sleep.wait_60_seconds_2 ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "metallb"
  repo_name  = "metallb"
  chart_name = "metallb"
  namespace  = "metallb"
  values     = format(file("${path.module}/etc/metallb-config.yaml"), var.metallb_address_pool)
}

################################################################
##
##       ExternalDNS
##
################################################################

resource "rancher2_app_v2" "external_dns" {
  depends_on = [ rancher2_catalog_v2.bitnami,
                 time_sleep.wait_60_seconds_2 ]
  provider   = rancher2.admin
  cluster_id = data.rancher2_cluster.local.id

  name       = "external-dns"
  repo_name  = "bitnami"
  chart_name = "external-dns"
  namespace  = "external-dns"
  values     = format(file("${path.module}/etc/external-dns-config.yaml"), var.dns_server, var.dns_port, var.searchdomain)
}

