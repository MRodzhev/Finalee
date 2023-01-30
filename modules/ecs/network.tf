data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "privatesubnet" {
  count = length(var.privateSubnetCIDR)
  cidr_block = tolist(var.privateSubnetCIDR)[count.index]
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    name = "privatesubnet"
  }
}


resource "aws_subnet" "publicsubnet" {
  count = length(var.publicSubnetCIDR)
  cidr_block = tolist(var.publicSubnetCIDR)[count.index]
  vpc_id = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    name = "publicsubnet"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        name = "igw"
    }
}

resource "aws_eip" "eip" {
  count = 3
  vpc = true
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "NatGW" {
  count = length(var.publicSubnetCIDR)
  allocation_id = aws_eip.eip[count.index].id
  subnet_id = "${element(aws_subnet.publicsubnet.*.id, count.index)}"
  
  tags = {
    Name = "NatGW"
  }
}



resource "aws_route" "internet_connection" {
    route_table_id = aws_vpc.main.main_route_table_id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}


resource "aws_route_table" "private_rt" {
  count = 3
  vpc_id = aws_vpc.main.id
  
    route {
       cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.NatGW.*.id, count.index)
   }
        tags = {
           name = "private_rt"
        }
    }
  

resource "aws_route_table_association" "private" {
    count = length(var.privateSubnetCIDR)
   subnet_id = aws_subnet.privatesubnet[count.index].id
    route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

resource "aws_route_table" "public_rt" {
   vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
        tags = {
            name = "public_rt"
        }
    }

    resource "aws_route_table_association" "public" {
    count = length(var.publicSubnetCIDR)
    subnet_id = aws_subnet.publicsubnet[count.index].id
    route_table_id = aws_route_table.public_rt.id
  
}        