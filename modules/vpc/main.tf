resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}


resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidr_blocks

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidr_blocks

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "this" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.this.id
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}







