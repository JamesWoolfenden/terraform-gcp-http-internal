# holden:ignore:HLD_GCP_106 — internal HTTP load balancer by design; HTTPS requires cert management outside this module's scope
resource "google_compute_forwarding_rule" "default" {
  for_each = var.regions

  name                  = "${each.key}-forwarding-rule"
  region                = each.key
  project               = var.project
  load_balancing_scheme = "INTERNAL_MANAGED"
  target                = google_compute_region_target_http_proxy.default[each.key].id
  network               = var.network
  subnetwork            = each.value.subnetwork
  ip_protocol           = "TCP"
  port_range            = tostring(var.port)
  allow_global_access   = false
}
