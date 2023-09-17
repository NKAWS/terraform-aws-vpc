resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = local.instance_tenancy
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = var.tags

}