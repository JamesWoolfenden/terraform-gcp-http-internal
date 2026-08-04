resource "google_compute_region_backend_service" "default" {
  for_each = var.regions

  name                  = "${each.key}-backend"
  region                = each.key
  project               = var.project
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 30
  security_policy       = google_compute_region_security_policy.default[each.key].id

  backend {
    group           = google_compute_region_instance_group_manager.region[each.key].instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_region_health_check.default[each.key].id]

  connection_draining_timeout_sec = 1

  log_config {
    enable      = true
    sample_rate = 1.0
  }
}
