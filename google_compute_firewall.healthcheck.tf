resource "google_compute_firewall" "healthcheck" {
  name          = "default-allow-health-check"
  network       = var.network
  source_ranges = var.source_ranges

  allow {
    protocol = "tcp"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
