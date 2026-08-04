variable "project" {
  type        = string
  description = "The GCP project to deploy resources into."
  default     = "pike-477416"
  validation {
    condition     = length(var.project) > 0
    error_message = "project must be a non-empty string."
  }
}

variable "regions" {
  type = map(object({
    cidr                      = string
    proxy_cidr                = string
    distribution_policy_zones = list(string)
  }))
  description = "Map of region name to its network config for the example deployment."
  default = {
    "us-east1" = {
      cidr                      = "10.0.0.0/24"
      proxy_cidr                = "10.0.1.0/24"
      distribution_policy_zones = ["us-east1-b", "us-east1-c", "us-east1-d"]
    }
    "europe-west1" = {
      cidr                      = "10.0.2.0/24"
      proxy_cidr                = "10.0.3.0/24"
      distribution_policy_zones = ["europe-west1-b", "europe-west1-c", "europe-west1-d"]
    }
  }
  validation {
    condition     = length(var.regions) > 0
    error_message = "regions must contain at least one region."
  }
}

variable "source_ranges" {
  type        = list(string)
  description = "Source IP ranges allowed by the firewall rule."
  default     = ["130.211.0.0/22", "35.191.0.0/16"]
  validation {
    condition     = length(var.source_ranges) > 0
    error_message = "source_ranges must contain at least one CIDR range."
  }
}

variable "http_source_ranges" {
  type        = list(string)
  description = "Source IP ranges allowed by the HTTP/HTTPS ingress firewall rule."
  default     = ["10.0.0.0/8"]
  validation {
    condition     = length(var.http_source_ranges) > 0
    error_message = "http_source_ranges must contain at least one CIDR range."
  }
}

variable "armor_deny_ranges" {
  type        = list(string)
  description = "Source IP ranges that Cloud Armor will deny with HTTP 403."
  default     = ["192.0.2.0/24"]
  validation {
    condition     = length(var.armor_deny_ranges) > 0
    error_message = "armor_deny_ranges must be a non-empty list of strings."
  }
}
