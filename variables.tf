variable common_tags {
  description = "This is to help you add tags to your cloud objects"
  type        = map
}

variable project {
  type = string
}

variable network {
  type = string
}

variable source_tags {
  type = list
}
