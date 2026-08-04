resource "google_compute_region_url_map" "default" {
  for_each = var.regions

  name            = "${each.key}-url-map"
  region          = each.key
  project         = var.project
  default_service = google_compute_region_backend_service.default[each.key].id
}
