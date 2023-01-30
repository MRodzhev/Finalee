variable "aws_profile" {
  default = "rodzhev"
}

variable "region" {
  
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "privateSubnetCIDR" {
  type = list(string)
  
}

variable "publicSubnetCIDR" {
  type = list(string)
  
}
variable "allowed_ports" {
  type    = list(number)
  #default = [22, 80, 443, 5000]
}


variable "cidr_block" {
  type = string
  #default = "0.0.0.0/0"
}

variable "image_tag" {
  default = "0.0.1"
  type = string
  
}

variable "env" {
  type    = string
  default = "project"
}

variable "app_name" {
  type = string
  
}

variable "git_trigger_event" {
  type    = string
  default = "PUSH"
}

variable "branch_pattern" {
  type    = string
  default = "main"
}

variable "github_oauth_token" {
  type    = string
  default = ""
}
  
variable "repo_url" {
  type = string
  
}
variable "name_container" {
  default = "jackrussel"
}

variable "bucket_name" {
  type        = string
  description = "S3 Bucket name"
  default     = "mrodzhev-s3-bucket"
}

