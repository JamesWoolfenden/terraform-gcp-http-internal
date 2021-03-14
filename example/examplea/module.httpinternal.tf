module "httpinternal" {
  source      = "../../"
  common_tags = var.common_tags
  project     = "examplea"
  network     = data.google_compute_network.default
}
