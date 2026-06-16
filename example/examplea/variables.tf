variable "project" {
  type        = string
  description = "The GCP project to deploy resources into."
  default     = "pike-477416"
  validation {
    condition     = length(var.project) > 0
    error_message = "project must be a non-empty string."
  }
}

variable "region" {
  type        = string
  description = "The GCP region to deploy resources into."
  default     = "us-east1"
  validation {
    condition     = length(var.region) > 0
    error_message = "region must be a non-empty string."
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
