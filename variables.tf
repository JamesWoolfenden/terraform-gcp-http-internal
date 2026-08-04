variable "project" {
  type        = string
  description = "The project to deploy the resources into."
  validation {
    condition     = length(var.project) > 0
    error_message = "project must be a non-empty string."
  }
}

variable "network" {
  type        = string
  description = "The network to deploy the resources into."
  validation {
    condition     = length(var.network) > 0
    error_message = "network must be a non-empty string."
  }
}


variable "source_ranges" {
  type        = list(string)
  description = "The source ranges allowed to reach the firewall rules. Must be either one of GCP's own fixed health-check/IAP probe ranges (used as-is), or an RFC1918 private range no broader than /24 -- this module builds an internal-only load balancer, so neither a public range nor a sprawling /8-/23 internal grant is valid here."
  validation {
    condition = length(var.source_ranges) > 0 && alltrue([
      for r in var.source_ranges :
      anytrue([
        for pattern in [
          "^130\\.211\\.[0-3]\\.",            # GCP global LB health-check range 130.211.0.0/22
          "^35\\.191\\.",                     # GCP global LB health-check range 35.191.0.0/16
          "^35\\.235\\.(24[0-9]|25[0-5])\\.", # GCP IAP TCP forwarding range 35.235.240.0/20
        ] : can(regex(pattern, r))
        ]) || (
        anytrue([
          for pattern in [
            "^10\\.",                           # RFC1918 10.0.0.0/8
            "^172\\.(1[6-9]|2[0-9]|3[0-1])\\.", # RFC1918 172.16.0.0/12
            "^192\\.168\\.",                    # RFC1918 192.168.0.0/16
          ] : can(regex(pattern, r))
        ]) && can(regex("/(2[4-9]|3[0-2])$", r)) # no broader than /24
      )
    ])
    error_message = "source_ranges must contain at least one CIDR range. Each range must be either one of GCP's own health-check/IAP probe ranges (130.211.0.0/22, 35.191.0.0/16, 35.235.240.0/20, used as-is), or an RFC1918 private range (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16) no broader than /24 -- this module builds an internal-only load balancer, and a /8 or /16 internal grant is barely narrower than the whole private address space."
  }
}

variable "scopes" {
  type        = list(string)
  description = "The scopes to assign to the service account."
  default = [
    "storage-ro",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/trace.append",
  ]
  validation {
    condition     = length(var.scopes) > 0
    error_message = "scopes must contain at least one scope."
  }
}

variable "regions" {
  type = map(object({
    subnetwork                = string
    distribution_policy_zones = list(string)
  }))
  description = "Map of region name to its regional config. One full internal LB stack (instance template, MIG, health check, backend service, url map, proxy, forwarding rule, security policy) is created per entry."
  validation {
    condition     = length(var.regions) > 0
    error_message = "regions must contain at least one region."
  }
  validation {
    condition     = alltrue([for r in var.regions : length(r.distribution_policy_zones) > 0])
    error_message = "each region's distribution_policy_zones must be a non-empty list of strings."
  }
}


variable "machine_type" {
  type        = string
  description = "The machine type to use for the instance template."
  default     = "n1-standard-1"
  validation {
    condition     = length(var.machine_type) > 0
    error_message = "machine_type must be a non-empty string."
  }
}

variable "service_account_email" {
  type        = string
  description = "Email of the dedicated service account to attach to instance templates."
  validation {
    condition     = length(var.service_account_email) > 0
    error_message = "service_account_email must be a non-empty string."
  }
}

variable "health_check_path" {
  type        = string
  description = "The HTTP path used by the regional health check."
  default     = "/"
  validation {
    condition     = startswith(var.health_check_path, "/")
    error_message = "health_check_path must begin with /."
  }
}

variable "armor_deny_ranges" {
  type        = list(string)
  description = "Source IP ranges that Cloud Armor will deny with HTTP 403. Must contain at least one entry."
  validation {
    condition     = length(var.armor_deny_ranges) > 0
    error_message = "armor_deny_ranges must contain at least one CIDR range."
  }
}

variable "port" {
  type        = number
  description = "The single TCP port this internal load balancer serves and health-checks on. Referenced consistently by the health check, the MIG's named port, the forwarding rule, and both firewalls -- there is exactly one port for the whole pipeline."
  default     = 80
  validation {
    condition     = var.port > 0 && var.port <= 65535
    error_message = "port must be a valid TCP port number (1-65535)."
  }
}

variable "target_size" {
  type        = number
  description = "The target number of running instances in the managed instance group."
  default     = 2
  validation {
    condition     = var.target_size > 0
    error_message = "target_size must be greater than 0."
  }
}
