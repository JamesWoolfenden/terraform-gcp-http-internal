resource "google_compute_region_instance_group_manager" "us-east" {
  base_instance_name = "us-east1-mig"
  name               = "us-east1-mig"
  instance_template  = google_compute_instance_template.us-east1-template.self_link
  region             = "us-east1"
  distribution_policy_zones = [
    "us-east1-b",
    "us-east1-c",
    "us-east1-d",
  ]
  project = var.project
}


/*
Property	Value (type value or select option as specified)
Name	us-east1-mig
Location	Multi-zone
Region	us-east1
Instance template	us-east1-template
Autoscale based on	CPU usage
Target CPU usage	80
Minimum number of instances	1
Maximum number of instances	5
Cool-down period	45
autoscalers?
https://www.terraform.io/docs/providers/google/r/compute_region_autoscaler.html
*/
