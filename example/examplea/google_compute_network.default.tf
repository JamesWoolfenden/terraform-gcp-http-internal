resource "google_compute_network" "this" {
  name                            = "prod-network"
  project                         = "pike-477416"
  delete_default_routes_on_create = true
}

resource "google_compute_firewall" "default" {
  name    = "prod-network-allow-http"
  project = "pike-477416"
  network = google_compute_network.this.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  direction     = "INGRESS"
  source_ranges = var.http_source_ranges

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }

}
