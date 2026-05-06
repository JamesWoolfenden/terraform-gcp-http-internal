module "httpinternal" {
  source      = "../../"
  common_tags = var.common_tags
  project     = "pike-477416"
  network     = data.google_compute_network.default
}
