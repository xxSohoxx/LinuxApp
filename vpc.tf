module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
}

module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.vpc.main_vpc_id
  igw_name = "my-internet-gateway"
}

resource "aws_route_table" "subnet_route_table" {
  vpc_id = module.vpc.main_vpc_id

  tags = var.tags
}

resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.subnet_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.igw.igw_id
}

resource "aws_main_route_table_association" "this" {

  vpc_id         = module.vpc.main_vpc_id
  route_table_id = aws_route_table.subnet_route_table.id
}
