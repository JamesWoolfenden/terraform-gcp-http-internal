output "http_internal" {
  value       = module.http_internal
  description = "Outputs from the http_internal module"
}

output "network" {
  value       = google_compute_network.this.self_link
  description = "The self-link of the network created by this module."
}

output "subnetwork" {
  value       = google_compute_subnetwork.default.self_link
  description = "The self-link of the subnetwork created by this module."
}

output "sa" {
  value       = google_service_account.default.email
  description = "The email of the service account created by this module."
}
