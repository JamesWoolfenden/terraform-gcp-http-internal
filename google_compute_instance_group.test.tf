resource "google_compute_instance_group" "test" {
  name        = "us-east1-mig"
  description = "Terraform test instance group"
  zone        = "us-central1-a"
  network     = google_compute_network.default.self_link
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
*/