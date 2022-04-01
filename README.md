## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.7.1 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | >= 1.22.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.7.1 |
| <a name="provider_rancher2.admin"></a> [rancher2.admin](#provider\_rancher2.admin) | >= 1.22.2 |
| <a name="provider_rancher2.bootstrap"></a> [rancher2.bootstrap](#provider\_rancher2.bootstrap) | >= 1.22.2 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cert-manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.rancher](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.rancher](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.rancher_tls](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.tls_ca](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [rancher2_app_v2.external_dns](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app_v2) | resource |
| [rancher2_app_v2.longhorn](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app_v2) | resource |
| [rancher2_app_v2.metallb](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app_v2) | resource |
| [rancher2_bootstrap.admin](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/bootstrap) | resource |
| [rancher2_catalog_v2.bitnami](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog_v2) | resource |
| [rancher2_catalog_v2.metallb](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/catalog_v2) | resource |
| [random_password.bootstrap_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_sleep.wait_30_seconds_2](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_60_seconds_1](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_60_seconds_2](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [rancher2_cluster.local](https://registry.terraform.io/providers/rancher/rancher2/latest/docs/data-sources/cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_crt"></a> [ca\_crt](#input\_ca\_crt) | n/a | `string` | n/a | yes |
| <a name="input_dns_port"></a> [dns\_port](#input\_dns\_port) | n/a | `string` | n/a | yes |
| <a name="input_dns_server"></a> [dns\_server](#input\_dns\_server) | n/a | `string` | n/a | yes |
| <a name="input_k8s_config_path"></a> [k8s\_config\_path](#input\_k8s\_config\_path) | n/a | `string` | n/a | yes |
| <a name="input_k8s_host"></a> [k8s\_host](#input\_k8s\_host) | n/a | `string` | n/a | yes |
| <a name="input_metallb_address_pool"></a> [metallb\_address\_pool](#input\_metallb\_address\_pool) | n/a | `string` | n/a | yes |
| <a name="input_no_proxy"></a> [no\_proxy](#input\_no\_proxy) | n/a | `string` | n/a | yes |
| <a name="input_proxy"></a> [proxy](#input\_proxy) | n/a | `string` | n/a | yes |
| <a name="input_rancher_host"></a> [rancher\_host](#input\_rancher\_host) | n/a | `string` | n/a | yes |
| <a name="input_rancher_password"></a> [rancher\_password](#input\_rancher\_password) | n/a | `string` | n/a | yes |
| <a name="input_rancher_tls_crt"></a> [rancher\_tls\_crt](#input\_rancher\_tls\_crt) | n/a | `string` | n/a | yes |
| <a name="input_rancher_tls_key"></a> [rancher\_tls\_key](#input\_rancher\_tls\_key) | n/a | `string` | n/a | yes |
| <a name="input_searchdomain"></a> [searchdomain](#input\_searchdomain) | n/a | `string` | n/a | yes |
| <a name="input_k8s_client_certificate"></a> [k8s\_client\_certificate](#input\_k8s\_client\_certificate) | n/a | `string` | `""` | no |
| <a name="input_k8s_client_key"></a> [k8s\_client\_key](#input\_k8s\_client\_key) | n/a | `string` | `""` | no |
| <a name="input_k8s_cluster_ca_certificate"></a> [k8s\_cluster\_ca\_certificate](#input\_k8s\_cluster\_ca\_certificate) | n/a | `string` | `""` | no |
| <a name="input_k8s_cluster_client_token"></a> [k8s\_cluster\_client\_token](#input\_k8s\_cluster\_client\_token) | n/a | `string` | `""` | no |
| <a name="input_longhorn_data_path"></a> [longhorn\_data\_path](#input\_longhorn\_data\_path) | n/a | `string` | `"/data/longhorn"` | no |
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | n/a | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | n/a |
| <a name="output_admin_token"></a> [admin\_token](#output\_admin\_token) | n/a |
| <a name="output_rancher_url"></a> [rancher\_url](#output\_rancher\_url) | n/a |
