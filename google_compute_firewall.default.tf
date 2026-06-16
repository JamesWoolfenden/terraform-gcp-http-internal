resource "google_compute_firewall" "default" {
  name    = "default-allow-http"
  network = var.network

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = var.source_ranges

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
