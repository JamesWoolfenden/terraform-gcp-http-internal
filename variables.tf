variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map(any)
}

variable "project" {
  type = string
}

variable "network" {
}

variable "source_ranges" {
  default = ["0.0.0.0/0"]
}
