locals {
  repository_name = format("%s-%s", var.app_name, var.env)
}

variable "env" {
  description = "The environment of the project"
  default     = "project"
  type = string
}

variable "app_name" {
  default = "simpleapp"
  type = string
  
}