output "forwarding_rule" {
  description = "The internal forwarding rule (load balancer entry point)."
  value       = google_compute_forwarding_rule.default
}

output "backend_service" {
  description = "The regional backend service."
  value       = google_compute_region_backend_service.default
}

output "security_policy" {
  description = "The Cloud Armor regional security policy."
  value       = google_compute_region_security_policy.default
}

output "instance_group_manager" {
  description = "The regional managed instance group."
  value       = google_compute_region_instance_group_manager.region
}

output "health_check" {
  description = "The regional HTTP health check."
  value       = google_compute_region_health_check.default
}
