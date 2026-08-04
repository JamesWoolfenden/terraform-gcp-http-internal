resource "google_compute_region_target_http_proxy" "default" {
  for_each = var.regions

  name    = "${each.key}-http-proxy"
  region  = each.key
  project = var.project
  url_map = google_compute_region_url_map.default[each.key].id
}
