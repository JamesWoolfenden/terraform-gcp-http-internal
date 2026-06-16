# holden:ignore:HLD_GCP_106 — internal HTTP load balancer by design; HTTPS requires cert management outside this module's scope
resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.region}-forwarding-rule"
  region                = var.region
  project               = var.project
  load_balancing_scheme = "INTERNAL_MANAGED"
  target                = google_compute_region_target_http_proxy.default.id
  network               = var.network
  subnetwork            = var.subnetwork
  ip_protocol           = "TCP"
  port_range            = "80"
  allow_global_access   = false
}
