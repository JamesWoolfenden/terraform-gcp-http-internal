resource "google_compute_router" "this" {
  for_each = var.regions

  name    = "prod-router-${each.key}"
  region  = each.key
  project = var.project
  network = google_compute_network.this.id
}

resource "google_compute_router_nat" "this" {
  for_each = var.regions

  name                               = "prod-nat-${each.key}"
  region                             = each.key
  project                            = var.project
  router                             = google_compute_router.this[each.key].name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  enable_dynamic_port_allocation     = true
  min_ports_per_vm                   = 64
  max_ports_per_vm                   = 2048

  subnetwork {
    name                    = google_compute_subnetwork.default[each.key].id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ALL"
  }
}
