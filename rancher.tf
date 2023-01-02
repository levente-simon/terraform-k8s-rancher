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
    prevent_destroy = true
    ignore_changes  = all 
  }

  metadata {
    name = "cattle-system"
  }
}

resource "kubernetes_manifest" "cert_rancher" {
  depends_on = [ kubernetes_namespace.rancher ]

  lifecycle {
    prevent_destroy = true
  }

  manifest   = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "Certificate"
    "metadata"   = {
      "name"        = "tls-rancher-ingress"
      "namespace"   = "cattle-system"
    }
    "spec"       = {
      "secretName"  = "tls-rancher-ingress"
      "duration"    = "24h0m0s"
      "renewBefore" = "2h0m0s"
      "subject"     = {
        "organizations" = [ "Corp" ]
      }
      "privateKey"  = {
        "algorithm"     = "RSA"
        "encoding"      = "PKCS1"
        "size"          = "2048"
      }
      "usages"      = [ "server auth"  ]
      "dnsNames"    = [ "${var.rancher_host}" ]
      "issuerRef"   = { 
        "name"  = "vault-issuer"
        "kind"  = "ClusterIssuer"
      }
    }
  }
}

resource "kubernetes_secret" "tls_ca" {
  depends_on = [ kubernetes_namespace.rancher ]

  lifecycle {
    prevent_destroy = true
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

resource "time_sleep" "wait_for_certs" {
  depends_on      = [ kubernetes_manifest.cert_rancher,
                      kubernetes_secret.tls_ca ]
  create_duration = "10s"
}

resource "helm_release" "rancher" {
  depends_on       = [ time_sleep.wait_for_certs,
                       random_password.bootstrap_password ]

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all 
  }

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

resource "time_sleep" "wait_20_seconds" {
  depends_on      = [ helm_release.rancher ]
  create_duration = "20s"
}

resource "rancher2_bootstrap" "admin" {
  depends_on = [ time_sleep.wait_30_seconds_2 ]
  provider   = rancher2.bootstrap

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all 
  }

  initial_password = random_password.bootstrap_password.result
  telemetry        = false
  password         = var.rancher_password
}

