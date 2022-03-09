terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = ">= 1.3.0"
    }
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
  config_path = var.k8s_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.k8s_config_path
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
