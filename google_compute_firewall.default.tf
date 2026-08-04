resource "google_compute_firewall" "default" {
  name        = "default-allow-http"
  network     = var.network
  target_tags = ["http-internal-lb-backend"]

  # protocol/port match every other stage of this pipeline via var.port
  # (google_compute_forwarding_rule.default port_range, google_compute_region_backend_service.default
  # port_name "http", google_compute_region_health_check.default port, and the MIG's named_port)
  # -- nothing downstream ever listens on any other protocol/port, so this was never meant to be
  # independently configurable.
  allow {
    protocol = "tcp"
    ports    = [tostring(var.port)]
  }

  source_ranges = var.source_ranges

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
