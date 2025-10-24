# ---------------------
# VPC
# ---------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = var.vpc_name },
    var.tags
  )
}
# ---------------------
# Internet Gateway
# ---------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    { Name = "${var.vpc_name}-igw" },
    var.tags
  )
}
# ---------------------
# Public Subnets
# ---------------------
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(var.azs, index(keys(var.public_subnets), each.key))
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "${var.vpc_name}-${each.key}" },
    var.tags
  )
}
# ---------------------
# Private Subnets
# ---------------------
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(var.azs, index(keys(var.private_subnets), each.key))

  tags = merge(
    { Name = "${var.vpc_name}-${each.key}" },
    var.tags
  )
}
# ---------------------
# Public Route Table
# ---------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    { Name = "${var.vpc_name}-public-rt" },
    var.tags
  )
}
# ---------------------
# Private Route Table
# ---------------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    { Name = "${var.vpc_name}-private-rt" },
    var.tags
  )
}
# ---------------------
# Route Table Associations
# ---------------------
resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
