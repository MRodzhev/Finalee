variable "aws_region" {
  description = "aws region"
  default = "eu-central-1"
}

variable "aws_profile" {
  description = "aws profile"
}

variable "image_tag" {
    type = string
}

variable "working_dir" {
    type = string
}

variable "app_name" {
    type = string
}

variable "env" {
    type = string
}