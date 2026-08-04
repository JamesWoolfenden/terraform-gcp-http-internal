resource "google_compute_region_instance_group_manager" "region" {
  for_each = var.regions

  base_instance_name        = "${each.key}-mig"
  name                      = "${each.key}-mig"
  region                    = each.key
  distribution_policy_zones = each.value.distribution_policy_zones
  project                   = var.project
  target_size               = var.target_size

  version {
    instance_template = google_compute_instance_template.region[each.key].id
  }

  named_port {
    name = "http"
    port = var.port
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.default[each.key].id
    initial_delay_sec = 300
  }

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "REPLACE"
    max_surge_fixed       = length(each.value.distribution_policy_zones)
    max_unavailable_fixed = 0
  }
}
