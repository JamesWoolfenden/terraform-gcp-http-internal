# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "httpinternal" {
  source      = "../../"
  common_tags = var.common_tags
  project     = "pike-477416"
  network     = data.google_compute_network.default
}
