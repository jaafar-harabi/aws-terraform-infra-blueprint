variable "name"     { type = string }
variable "cidr"     { type = string }
variable "az_count" { type = number }

data "aws_availability_zones" "az" {}

locals {
  azs = slice(data.aws_availability_zones.az.names, 0, var.az_count)
}

resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.name}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags   = { Name = "${var.name}-igw" }
}

resource "aws_subnet" "public" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr, 4, count.index)
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${count.index}" }
}

output "vpc_id"         { value = aws_vpc.this.id }
output "public_subnets" { value = aws_subnet.public[*].id }
