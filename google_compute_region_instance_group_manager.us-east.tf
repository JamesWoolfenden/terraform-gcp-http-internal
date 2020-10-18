resource "google_compute_region_instance_group_manager" "us-east" {
  base_instance_name = "us-east1-mig"
  name               = "us-east1-mig"
  version {
    instance_template = google_compute_instance_template.us-east1-template.id
  }
  region = "us-east1"
  distribution_policy_zones = [
    "us-east1-b",
    "us-east1-c",
    "us-east1-d",
  ]
  project = var.project
}
