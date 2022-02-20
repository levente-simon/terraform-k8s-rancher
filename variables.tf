variable "os_user"                { type = string   }
variable "cluster_hosts"          { type = map(any) }
variable "k8s_config_path"        { type = string   }
variable "metallb_address_pool"   { type = string   }
variable "proxy"                  { type = string   }
variable "no_proxy"               { type = string   }
variable "rancher_host"           { type = string   }
variable "dns_server"             { type = string   }
variable "dns_port"               { type = string   }
variable "searchdomain"           { type = string   }

variable "rancher_password" {
  type      = string
  sensitive = true
}

variable "ssh_private_key" {
  type      = string
  sensitive = true
}