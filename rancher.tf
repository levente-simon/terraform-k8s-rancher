resource "helm_release" "cert-manager" {
  depends_on       = [ local_file.kube_config ]
  name             = "cert-manager"

  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "time_sleep" "wait_60_seconds_1" {
  depends_on      = [ helm_release.cert-manager ]
  create_duration = "60s"
}

resource "random_password" "bootstrap_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

#resource "kubernetes_namespace" "rancher" {
#  depends_on       = [ time_sleep.wait_60_seconds_1 ]
#
#  lifecycle {
#    ignore_changes  = all 
#  }
#
#  metadata {
#    name = "cattle-system"
#  }
#}
#

resource "helm_release" "rancher" {
  depends_on       = [ random_password.bootstrap_password ]

  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/stable"
  chart            = "rancher"
  namespace        = "cattle-system"
  create_namespace = true

  set {
    name  = "hostname"
    value = var.rancher_host
  }
  set {
    name  = "bootstrapPassword"
    value = random_password.bootstrap_password.result
  }
  set {
    name  = "proxy"
    value = var.proxy
  }
  set {
    name  = "noProxy"
    value = var.no_proxy
  }

  set {
    name  = "ingress.tls.source"
    value = "secret"
  }

  set {
    name  = "privateCA"
    value = "true"
  }
}

resource "kubernetes_secret" "rancher_tls" {
  depends_on = [ helm_release.rancher ]
  metadata {
    name       = "tls-rancher-ingress"
    namespace  = "cattle-system"
  }

  type       = "kubernetes.io/tls"
  data       = {
      "tls.crt" = var.rancher_tls_crt
      "tls.key" = var.rancher_tls_key
  }
}

resource "kubernetes_secret" "tls_ca" {
  depends_on = [ helm_release.rancher ]
  metadata {
    name       = "tls-ca"
    namespace  = "cattle-system"
  }

  data       = {
      "cacerts.pem"  = var.ca_crt
  }
}


resource "time_sleep" "wait_30_seconds_2" {
  depends_on      = [ kubernetes_secret.tls_ca,
                      kubernetes_secret.rancher_tls ]
  create_duration = "30s"
}

resource "rancher2_bootstrap" "admin" {
  depends_on = [ time_sleep.wait_30_seconds_2 ]
  provider   = rancher2.bootstrap

  initial_password = random_password.bootstrap_password.result
  telemetry        = false
  password         = var.rancher_password
}

