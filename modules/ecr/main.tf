resource "aws_ecr_repository" "ecr_repo" {
  name = local.repository_name
}