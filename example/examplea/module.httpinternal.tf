# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "http_internal" {
  source                = "../../"
  project               = var.project
  region                = var.region
  network               = google_compute_network.this.self_link
  subnetwork            = google_compute_subnetwork.default.self_link
  machine_type          = "n1-standard-1"
  source_ranges         = var.source_ranges
  armor_deny_ranges     = var.armor_deny_ranges
  service_account_email = google_service_account.default.email
}
