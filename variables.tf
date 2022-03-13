variable "k8s_config_path"        { type = string   }
variable "metallb_address_pool"   { type = string   }
variable "proxy"                  { type = string   }
variable "no_proxy"               { type = string   }
variable "rancher_host"           { type = string   }
variable "dns_server"             { type = string   }
variable "dns_port"               { type = string   }
variable "searchdomain"           { type = string   }
variable "rancher_tls_crt"        { type = string   }
variable "rancher_tls_key"        { type = string   }
variable "ca_crt"                 { type = string   }

variable "rancher_password" {
  type      = string
  sensitive = true
}


variable "k8s_host" {
  type      = string
  sensitive = true
}

variable "k8s_client_certificate" {
  type      = string
  sensitive = true
  default   = ""
}

variable "k8s_client_key" {
  type      = string
  sensitive = true
  default   = ""
}

variable "k8s_cluster_ca_certificate" {
  type      = string
  sensitive = true
  default   = ""
}

variable "k8s_cluster_client_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "longhorn_data_path" {
  type    = string
  default = "/data/longhorn"
}