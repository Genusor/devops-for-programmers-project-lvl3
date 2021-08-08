variable "do_token" {
  type      = string
  sensitive = true
} 

variable "datadog_api_key" {
  type      = string
  sensitive = true
}

variable "datadog_app_key" {
  type      = string
  sensitive = true
}

variable "ssh_key" {}
