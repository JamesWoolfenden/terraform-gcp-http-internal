resource "google_compute_firewall" "default" {
  name    = "default-allow-http"
  network = var.network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = var.source_ranges
}
