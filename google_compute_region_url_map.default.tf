resource "google_compute_region_url_map" "default" {
  name            = "${var.region}-url-map"
  region          = var.region
  project         = var.project
  default_service = google_compute_region_backend_service.default.id
}
