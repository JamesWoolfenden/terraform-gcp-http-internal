
resource "google_compute_subnetwork" "default" {
  name                     = "prod-subnet"
  region                   = var.region
  project                  = var.project
  network                  = google_compute_network.this.id
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "proxy" {
  name          = "prod-proxy-subnet"
  region        = var.region
  project       = var.project
  network       = google_compute_network.this.id
  ip_cidr_range = "10.0.1.0/24"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}
