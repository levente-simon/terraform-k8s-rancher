terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">= 1.22.2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }
  }
}

provider "kubernetes" {
  host                   = var.k8s_host
  client_certificate     = var.k8s_client_certificate
  client_key             = var.k8s_client_key
  cluster_ca_certificate = var.k8s_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = var.k8s_host
    client_certificate     = var.k8s_client_certificate
    client_key             = var.k8s_client_key
    cluster_ca_certificate = var.k8s_cluster_ca_certificate
  }
}

provider "rancher2" {
  alias = "bootstrap"

  api_url    = "https://${var.rancher_host}"
  bootstrap = true
  insecure  = true
}

provider "rancher2" {
  alias      = "admin"

  api_url    = "https://${var.rancher_host}"
  token_key  = rancher2_bootstrap.admin.token
  insecure   = true
}

