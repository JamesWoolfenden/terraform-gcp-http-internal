data "google_compute_image" "debian" {
  family  = var.image_family
  project = var.image_project
}
