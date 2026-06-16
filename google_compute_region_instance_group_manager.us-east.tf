resource "google_compute_region_instance_group_manager" "region" {
  base_instance_name        = "${var.region}-mig"
  name                      = "${var.region}-mig"
  region                    = var.region
  distribution_policy_zones = var.distribution_policy_zones
  project                   = var.project

  version {
    instance_template = google_compute_instance_template.us_east1_template.id
  }

  named_port {
    name = "http"
    port = 80
  }
}
