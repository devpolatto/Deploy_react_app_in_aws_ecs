// =================================================================
resource "aws_subnet" "subnet-public-a" {
  vpc_id            = local.vpc_id
  cidr_block        = "192.168.30.0/24"
  availability_zone = "${local.region}a"
  tags              = merge(var.common_tags, { Name = "subnet-deploy-public-a" })
}

resource "aws_subnet" "subnet-public-b" {
  vpc_id            = local.vpc_id
  cidr_block        = "192.168.40.0/24"
  availability_zone = "${local.region}b"
  tags              = merge(var.common_tags, { Name = "subnet-deploy-public-b" })
}

resource "aws_route_table" "rt-public" {
  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }

  tags = merge({ Name = "rt-public" }, var.common_tags, { COMMENT = "Rota de saida para internet" })
}

resource "aws_route_table_association" "associate-a" {
  subnet_id      = aws_subnet.subnet-public-a.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "associate-b" {
  subnet_id      = aws_subnet.subnet-public-b.id
  route_table_id = aws_route_table.rt-public.id
}