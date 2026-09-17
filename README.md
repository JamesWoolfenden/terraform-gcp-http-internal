# HTTP Load Balancer with Cloud Armour

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-http-internal/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-http-internal)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-http-internal.svg)](https://github.com/JamesWoolfenden/terraform-gcp-http-internal/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_compute_firewall.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.healthcheck](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_instance_template.region](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_region_backend_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_backend_service) | resource |
| [google_compute_region_health_check.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_region_instance_group_manager.region](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) | resource |
| [google_compute_region_security_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_security_policy) | resource |
| [google_compute_region_target_http_proxy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_target_http_proxy) | resource |
| [google_compute_region_url_map.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_url_map) | resource |
| [google_compute_image.debian](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_armor_deny_ranges"></a> [armor\_deny\_ranges](#input\_armor\_deny\_ranges) | Source IP ranges that Cloud Armor will deny with HTTP 403. Must contain at least one entry. | `list(string)` | n/a | yes |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | The HTTP path used by the regional health check. | `string` | `"/"` | no |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | The image family to build instances from. Defaults to debian-12; debian-11 was removed from debian-cloud after it reached end of life. | `string` | `"debian-12"` | no |
| <a name="input_image_project"></a> [image\_project](#input\_image\_project) | The project hosting the image family. | `string` | `"debian-cloud"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The machine type to use for the instance template. | `string` | `"n1-standard-1"` | no |
| <a name="input_network"></a> [network](#input\_network) | The network to deploy the resources into. | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The single TCP port this internal load balancer serves and health-checks on. Referenced consistently by the health check, the MIG's named port, the forwarding rule, and both firewalls -- there is exactly one port for the whole pipeline. | `number` | `80` | no |
| <a name="input_project"></a> [project](#input\_project) | The project to deploy the resources into. | `string` | n/a | yes |
| <a name="input_regions"></a> [regions](#input\_regions) | Map of region name to its regional config. One full internal LB stack (instance template, MIG, health check, backend service, url map, proxy, forwarding rule, security policy) is created per entry. | <pre>map(object({<br/>    subnetwork                = string<br/>    distribution_policy_zones = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | The scopes to assign to the service account. | `list(string)` | <pre>[<br/>  "storage-ro",<br/>  "https://www.googleapis.com/auth/logging.write",<br/>  "https://www.googleapis.com/auth/monitoring.write",<br/>  "https://www.googleapis.com/auth/service.management.readonly",<br/>  "https://www.googleapis.com/auth/servicecontrol",<br/>  "https://www.googleapis.com/auth/trace.append"<br/>]</pre> | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Email of the dedicated service account to attach to instance templates. | `string` | n/a | yes |
| <a name="input_source_ranges"></a> [source\_ranges](#input\_source\_ranges) | The source ranges allowed to reach the firewall rules. Must be either one of GCP's own fixed health-check/IAP probe ranges (used as-is), or an RFC1918 private range no broader than /24 -- this module builds an internal-only load balancer, so neither a public range nor a sprawling /8-/23 internal grant is valid here. | `list(string)` | n/a | yes |
| <a name="input_target_size"></a> [target\_size](#input\_target\_size) | The target number of running instances in the managed instance group. | `number` | `2` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_backend_service"></a> [backend\_service](#output\_backend\_service) | The regional backend services, keyed by region. |
| <a name="output_forwarding_rule"></a> [forwarding\_rule](#output\_forwarding\_rule) | The internal forwarding rules (load balancer entry points), keyed by region. |
| <a name="output_health_check"></a> [health\_check](#output\_health\_check) | The regional HTTP health checks, keyed by region. |
| <a name="output_instance_group_manager"></a> [instance\_group\_manager](#output\_instance\_group\_manager) | The regional managed instance groups, keyed by region. |
| <a name="output_security_policy"></a> [security\_policy](#output\_security\_policy) | The Cloud Armor regional security policies, keyed by region. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.forwardingRules.create",
    "compute.forwardingRules.delete",
    "compute.forwardingRules.get",
    "compute.forwardingRules.setLabels",
    "compute.forwardingRules.update",
    "compute.healthChecks.useReadOnly",
    "compute.httpHealthChecks.useReadOnly",
    "compute.httpsHealthChecks.useReadOnly",
    "compute.instanceGroupManagers.create",
    "compute.instanceGroupManagers.delete",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroupManagers.update",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.get",
    "compute.networks.get",
    "compute.networks.updatePolicy",
    "compute.regionBackendServices.create",
    "compute.regionBackendServices.delete",
    "compute.regionBackendServices.get",
    "compute.regionBackendServices.update",
    "compute.regionBackendServices.use",
    "compute.regionHealthChecks.create",
    "compute.regionHealthChecks.delete",
    "compute.regionHealthChecks.get",
    "compute.regionHealthChecks.update",
    "compute.regionHealthChecks.useReadOnly",
    "compute.regionSecurityPolicies.create",
    "compute.regionSecurityPolicies.delete",
    "compute.regionSecurityPolicies.get",
    "compute.regionSecurityPolicies.update",
    "compute.regionTargetHttpProxies.create",
    "compute.regionTargetHttpProxies.delete",
    "compute.regionTargetHttpProxies.get",
    "compute.regionTargetHttpProxies.update",
    "compute.regionUrlMaps.create",
    "compute.regionUrlMaps.delete",
    "compute.regionUrlMaps.get",
    "compute.regionUrlMaps.update"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "compute.firewalls.get",
    "compute.forwardingRules.get",
    "compute.instanceGroupManagers.get",
    "compute.instanceTemplates.get",
    "compute.networks.get",
    "compute.regionBackendServices.get",
    "compute.regionHealthChecks.get",
    "compute.regionSecurityPolicies.get",
    "compute.regionTargetHttpProxies.get",
    "compute.regionUrlMaps.get"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-gcp-http-internal/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-gcp-http-internal/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
