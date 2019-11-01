
output "description" {
  value = data.google_compute_network.default.description
}

output "gateway_ipv4" {
  value = data.google_compute_network.default.gateway_ipv4
}

output "self_link" {
  value = data.google_compute_network.default.self_link
}
