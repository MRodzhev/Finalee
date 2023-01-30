
region = "eu-central-1"

privateSubnetCIDR = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

publicSubnetCIDR = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]

allowed_ports = ["80", "443", "22", "5000"]

cidr_block = "0.0.0.0/0"

image_tag = "0.0.1"

app_name = "simpleapp"

env = "project"

aws_profile = "default"

repo_url = "https://github.com/MRodzhev/Finalee.git"

git_trigger_event = "PUSH"

branch_pattern = "^refs/heads/main$"

name_container = "jackrussel"




