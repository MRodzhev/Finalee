SoftServe Academy final project
Deploying an application in docker container on AWS using Terraform.

For reaching this goal, I used the following tools:

- Terraform
- AWS CLI
- Docker

GOALS:
- Maximal automation 
- Minimal hard-coding 
- Optimal workflow of the infrastructure 

DESCRIPTION:
This solution was created to demonstrate the deployment of a web application in a Docker container.
It was built using "Infrastructure as Code" tool, precisely HashiCorp`s Terraform
It contains a web application, Terraform modules, root Terraform modules, and configuration files to create an infrastructure.

The "Finalee" repository contains:

- Terraform project
- Web application
- Root Terraform module
- Terraform modules: 
  Backend: Stores a Terraform state file, containing the code.
  Elastic container registry: Creates an Elastic container registry (ECR) repository to store Docker images.
  Initial-build: Builds and pushes initial Docker image to ECR repository.
  ECS cluster: Creates a VPC and a ECS cluster.
  Codebuild: Creates a Codebuild project.
 
 
 FILES and FOLDERS:
/app - application directory (app.py, Dockerfile, Makefile, requirements.txt, index.html)
Dockerfile - special file, containing script of instructions, to build Docker image
Makefile - special file, containing shell commands, to build and push Docker image to ECR repository
/ - root Terraform module
./config - configuration directory for buildspec.yml file
terraform.tfvars - Contains variable values for development environment (git branch "main")
secret.tfvars - Contains secrets (Github token) for Github repository (not presented in the repo)
buildspec.yml - Build SPEC for AWS Codebuild
backend.tf - Terraform configuration
variables.tf - Terraform variables
main.tf - Terraform main file
/modules - Terraform modules
backend - "S3 Terraform state" module directory
ecr - "Elastic container registry" module directory
initial-build - "Initial build" module directory
ecs - "ECS cluster" module directory
codebuild - "Codebuild" module directory

IMPLEMENTATION:

Preparation:
- Create an account on AWS
- Create an user with required permissions using AWS IAM
- Install Terraform, AWS CLI and Docker
- Create Github token
- Create secret.tfvars and add next content "github_oauth_token = YOUR GITHUB TOKEN"
- Make correct changes of variable values in *.tfvars

DEPLOYMENT:

Initial step:
Add AWS AIM user credentials to ~/.aws/credentials[default]
aws_access_key_id = YOUR AWS ACCESS KEY ID
aws_secret_access_key = YOUR AWS SECRET ACCESS KEY

Steps:
Comment backend "s3" in ./terraform/backend.tf file
Comment modules "ecs" and "codebuild? in main.tf file
terraform init
terraform apply 

Uncomment backend "s3" in ./terraform/backend.tf file
Uncomment modules "ecs" and "codebuild" in main.tf file
When Terraform ask you to merge S3 Bucket states, reply with Yes
terraform init
terraform apply

Check results:
Go to your AWS account and check created infrastructure resources

Go to AWS Console, EC2 panel and choose Load Balancer, copy the DNS name and paste it to the web browser. Finally check the information of the a web page.

![ProjectFinal](https://user-images.githubusercontent.com/106818714/217793761-91d3f220-8525-4dac-a53e-fc8846807bd7.png)
