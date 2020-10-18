module "httpinternal" {
  source      = "../../"
  common_tags = var.common_tags
  project     = "examplea"
  network     = ""
  source_tags = [""]
}
