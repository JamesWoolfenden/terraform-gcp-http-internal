
resource "google_compute_subnetwork" "default" {
  for_each = var.regions

  name                     = "prod-subnet-${each.key}"
  region                   = each.key
  project                  = var.project
  network                  = google_compute_network.this.id
  ip_cidr_range            = each.value.cidr
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "proxy" {
  for_each = var.regions

  name          = "prod-proxy-subnet-${each.key}"
  region        = each.key
  project       = var.project
  network       = google_compute_network.this.id
  ip_cidr_range = each.value.proxy_cidr
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}
