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
  description = "The source ranges to allow for the firewall rule."
  validation {
    condition     = length(var.source_ranges) > 0
    error_message = "source_ranges must contain at least one CIDR range."
  }
}

variable "allow" {
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
  default = [
    {
      protocol = "tcp"
      ports    = ["80"]
    }
  ]

  description = "The list of allowed protocols and ports for the firewall rule."
  validation {
    condition     = length(var.allow) > 0
    error_message = "allow must contain at least one protocol and port."
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

variable "subnetwork" {
  type        = string
  description = "The subnetwork to deploy the resources into."
  validation {
    condition     = length(var.subnetwork) > 0
    error_message = "subnetwork must be a non-empty string."
  }
}

variable "distribution_policy_zones" {
  type        = list(string)
  description = "The zones to deploy the resources into."
  validation {
    condition     = length(var.distribution_policy_zones) > 0
    error_message = "distribution_policy_zones must be a non-empty list of strings."
  }
  default = [
    "us-east1-b",
    "us-east1-c",
    "us-east1-d",
  ]
}

variable "region" {
  type        = string
  description = "The region to deploy the resources into."
  validation {
    condition     = length(var.region) > 0
    error_message = "region must be a non-empty string."
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
