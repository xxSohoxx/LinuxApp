/*
module "subnets" {
  source = "./modules/subnet"

  for_each = var.subnets

  vpc_id            = module.vpc.main_vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  subnet_name       = "${each.key}"
  tags = var.tags
}
*/

resource "aws_subnet" "public_subnets" {
  for_each = var.subnets

  vpc_id               = module.vpc.main_vpc_id
  availability_zone    = each.value.az
  cidr_block           = each.value.cidr_block
  tags = merge(
    {
      "Name" = each.key
    },
    var.tags
  )
}