variable "region" {
  default = "eu-central-1"
  type = string
}


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}


variable "privateSubnetCIDR" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "publicSubnetCIDR" {
  type = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(any)
  default     = ["80", "443", "22", "8080", "5000"]

}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

variable "cidr_block" {
  type = string
  description = "CIDR Block to allow Jenkins Access"
  
}

variable "HPcheck" {
  type = list

  default = [{

    healthy_threshold   = 3
    interval            = 30
    protocol            = "HTTP"
    unhealthy_threshold = 2
    timeout             = 10
    path                = "/"
    matcher             = "200"
   }]
}

variable "fargate_cpu" {
  default     = "1024"
  type = string
}

variable "fargate_memory" {
  default     = "2048"
  type = string
}
variable "env" {
  type    = string
  default = "project"
}

variable "app_name" {
  type = string
  
}

variable "ecr_repository_url" {
  type = string
}

variable "image_tag" {
  type = string
  
}

locals {
  app_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}
