module "httpinternal" {
  source      = "../../"
  common_tags = var.common_tags
  project     = "pike-gcp"
  network     = data.google_compute_network.default
}
