resource "google_compute_region_security_policy" "default" {
  name        = "${var.region}-cloud-armor"
  region      = var.region
  project     = var.project
  description = "Cloud Armor WAF policy for the internal HTTP load balancer"
  type        = "CLOUD_ARMOR"

  rules {
    action      = "deny(403)"
    priority    = 1000
    description = "Deny requests from configured block ranges"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = var.armor_deny_ranges
      }
    }
  }

  rules {
    action      = "allow"
    priority    = 2147483647
    description = "Default allow"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}
