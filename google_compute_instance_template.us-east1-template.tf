resource "google_compute_instance_template" "us-east1-template" {
  #checkov:skip=CKV_GCP_30:Example
  name = "us-east1-template"

  machine_type   = "n1-standard-1"
  can_ip_forward = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = data.google_compute_image.debian.self_link
    auto_delete  = true
    boot         = true
    disk_size_gb = 10
  }

  labels = {}

  network_interface {
    network    = var.network.name
    subnetwork = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/us-east1/subnetworks/default"
  }

  metadata = {
    startup-script-url     = "gs://cloud-training/gcpnet/httplb/startup.sh"
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
  }

  service_account {
    scopes = [
      "storage-ro",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append", ]
  }

}
