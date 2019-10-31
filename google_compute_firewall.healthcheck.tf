resource google_compute_firewall healthcheck {
  name          = "default-allow-health-check"
  network       = data.google_compute_network.default.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "tcp"
  }

  source_tags = var.source_tags
}
