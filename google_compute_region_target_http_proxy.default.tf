resource "google_compute_region_target_http_proxy" "default" {
  name    = "${var.region}-http-proxy"
  region  = var.region
  project = var.project
  url_map = google_compute_region_url_map.default.id
}
