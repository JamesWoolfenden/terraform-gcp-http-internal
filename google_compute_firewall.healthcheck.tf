resource "google_compute_firewall" "healthcheck" {
  name          = "default-allow-health-check"
  network       = var.network
  target_tags   = ["http-internal-lb-backend"]
  source_ranges = var.source_ranges

  allow {
    protocol = "tcp"
    ports    = [tostring(var.port)]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
