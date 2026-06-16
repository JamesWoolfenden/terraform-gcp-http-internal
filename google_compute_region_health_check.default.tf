resource "google_compute_region_health_check" "default" {
  name               = "${var.region}-http-hc"
  region             = var.region
  project            = var.project
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port         = 80
    request_path = var.health_check_path
  }
}
