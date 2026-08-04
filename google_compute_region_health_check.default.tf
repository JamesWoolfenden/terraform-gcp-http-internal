resource "google_compute_region_health_check" "default" {
  for_each = var.regions

  name               = "${each.key}-http-hc"
  region             = each.key
  project            = var.project
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port         = var.port
    request_path = var.health_check_path
  }
}
