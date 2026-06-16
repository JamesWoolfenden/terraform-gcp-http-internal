resource "google_service_account" "default" {
  account_id   = "http-internal-sa"
  display_name = "HTTP Internal LB Service Account"
  project      = var.project
}
