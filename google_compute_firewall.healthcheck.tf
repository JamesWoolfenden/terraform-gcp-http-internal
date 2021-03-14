resource "google_compute_firewall" "healthcheck" {
  name          = "default-allow-health-check"
  network       = var.network.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "tcp"
  }

}
