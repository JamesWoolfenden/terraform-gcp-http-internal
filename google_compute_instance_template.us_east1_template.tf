# holden:ignore:HLD_GCP_092
# holden:ignore:HLD_GCP_187
resource "google_compute_instance_template" "us_east1_template" {
  name = "useast1template"

  machine_type   = var.machine_type
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

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  metadata = {
    startup-script-url     = "gs://cloud-training/gcpnet/httplb/startup.sh"
    block-project-ssh-keys = true
    enable-oslogin         = "TRUE"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
  }

  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }

}
