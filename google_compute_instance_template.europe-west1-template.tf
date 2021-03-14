resource "google_compute_instance_template" "europe-west1-template" {
  name = "europe-west1-template"

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

  labels = var.common_tags

  network_interface {
    network    = var.network.name
    subnetwork = "https://www.googleapis.com/compute/v1/projects/${var.project}/regions/europe-west1/subnetworks/default"
    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    startup-script-url = "gs://cloud-training/gcpnet/httplb/startup.sh"
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
