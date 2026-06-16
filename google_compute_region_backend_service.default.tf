resource "google_compute_region_backend_service" "default" {
  name                  = "${var.region}-backend"
  region                = var.region
  project               = var.project
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 30
  security_policy       = google_compute_region_security_policy.default.id

  backend {
    group           = google_compute_region_instance_group_manager.region.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [google_compute_region_health_check.default.id]

  log_config {
    enable      = true
    sample_rate = 1.0
  }
}
