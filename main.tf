
provider "aws" {
  region = var.region
}
 
module "s3_terraform_state" {
  source      = "./modules/backend"
  bucket_name = var.bucket_name
}

module "ecr" {
  source = "./modules/ecr"
  
  
}

module "initial-build" {
  aws_profile = var.aws_profile
  source = "./modules/initial-build"
  working_dir = "${path.root}/app"
  app_name = "simpleapp"
  image_tag = var.image_tag
  env = var.env

  depends_on = [
    module.ecr
  ]
  
}

module "ecs" {
 source = "./modules/ecs"
  region = var.region
  cidr_block = "10.0.0.0/16"
  app_name = var.app_name
  ecr_repository_url = module.ecr.ecr_repository_url

  depends_on = [
    module.ecr, module.initial-build
  ]
  
}

module "codebuild" {
  source = "./modules/codebuild"
  vpc_id = module.ecs.vpc_id
  subnets = module.ecs.private_subnet_ids
  branch_pattern = var.branch_pattern
  git_trigger_event = var.git_trigger_event
  github_oauth_token = var.github_oauth_token
  buildspec_file = "./config/buildspec.yml"
  repo_url = var.repo_url
  
  depends_on = [
    module.ecs, module.ecr
  
  
}
