variable "module_depends_on" {
  type    = any
  default = []
}

resource "random_password" "bootstrap_password" {
  depends_on       = [ var.module_depends_on ]
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_namespace" "rancher" {
  depends_on       = [ random_password.bootstrap_password ]

  lifecycle {
    ignore_changes  = all 
  }

  metadata {
    name = "cattle-system"
  }
}

# resource "kubernetes_secret" "rancher_tls" {
#   depends_on = [ kubernetes_namespace.rancher ]
# 
#   lifecycle {
#     ignore_changes  = all 
#   }
# 
#   metadata {
#     name       = "tls-rancher-ingress"
#     namespace  = "cattle-system"
#   }
# 
#   type       = "kubernetes.io/tls"
#   data       = {
#       "tls.crt" = var.rancher_tls_crt
#       "tls.key" = var.rancher_tls_key
#   }
# }
# 
resource "kubernetes_secret" "tls_ca" {
  depends_on = [ kubernetes_namespace.rancher ]

  lifecycle {
    ignore_changes  = all 
  }

  metadata {
    name       = "tls-ca"
    namespace  = "cattle-system"
  }

  data       = {
      "cacerts.pem"  = var.ca_crt
  }
}

resource "helm_release" "rancher" {
  depends_on       = [ kubernetes_namespace.rancher,
                       random_password.bootstrap_password ]

  name             = "rancher"
  repository       = "https://releases.rancher.com/server-charts/stable"
  chart            = "rancher"
  namespace        = "cattle-system"
  create_namespace = true
  values     = [ "${format(file("${path.module}/etc/rancher-config.yaml"),
                     var.rancher_host,
                     random_password.bootstrap_password.result)}"
               ]
 
}

resource "time_sleep" "wait_30_seconds_2" {
  depends_on      = [ helm_release.rancher ]
  create_duration = "30s"
}

resource "rancher2_bootstrap" "admin" {
  depends_on = [ time_sleep.wait_30_seconds_2 ]
  provider   = rancher2.bootstrap

  initial_password = random_password.bootstrap_password.result
  telemetry        = false
  password         = var.rancher_password
}

