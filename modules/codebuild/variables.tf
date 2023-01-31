variable "github_oauth_token" {
}

variable "buildspec_file" {

  default = "config/buildspec.yml"
  type = string
}

variable "subnets" {
  type        = list(string)
  default     = null
  description = "The subnet IDs that include resources used by CodeBuild"
}

variable "security_groups" {
  type        = list(string)
  default     = null
  description = "The security group IDs used by CodeBuild to allow access to resources in the VPC"
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The VPC ID that CodeBuild uses"
}

variable "branch_pattern" {}

variable "git_trigger_event" {}

variable "repo_url" {
    type = string
  
}
variable "env_vars" {
  description = <<EOF
Pass env vars for codebuild project(in native for codebuild project format)
Example:
env_vars = [
      {
        "name"  = "SOME_KEY1"
        "value" = "SOME_VALUE1"
      },
      {
        "name"  = "SOME_KEY2"
        "value" = "SOME_VALUE2"
      },
    ]
EOF

  default = []
}

