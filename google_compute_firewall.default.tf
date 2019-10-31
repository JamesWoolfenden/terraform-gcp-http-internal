resource "google_compute_firewall" "default" {
  name    = "default-allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["http-server"]
}
