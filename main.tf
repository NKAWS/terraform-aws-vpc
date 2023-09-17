resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = local.instance_tenancy
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = var.vpc_tags

}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = var.igw_tags
}

resource "aws_subnet" "public" {
  #count = length(var.public_subnet_cidr) #count=2
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = {

    Name = var.public_subnet_names[count.index]

  }
}

# timing-public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = var.public_route_table_tags

}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr) # this will fetch the length of public subnets
  subnet_id      = element(aws_subnet.public[*].id, count.index) # this will iterate and each time it gives single element
  route_table_id = aws_route_table.public.id
}



# [project-name]-private-1a/1b
resource "aws_subnet" "private" {
  #count = length(var.private_subnet_cidr) #count=2
  count = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = local.azs[count.index]

  tags = var.private_route_table_tags
}

# timing-private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id


  tags = var.private_route_table_tags

}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr) # this will fetch the length of private subnets
  subnet_id      = element(aws_subnet.private[*].id, count.index) # this will iterate and each time it gives single element
  route_table_id = aws_route_table.private.id
}