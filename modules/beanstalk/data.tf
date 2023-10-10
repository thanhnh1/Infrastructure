data "aws_caller_identity" "current" {}

data "aws_vpc" "selected" {
  filter {
    name   = "isDefault"
    values = ["false"]
  }
}

data "aws_subnets" "public_subnet" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.selected.id}"]
  }

  tags = {
    SUB-Type = "Public"
  }
}

data "aws_subnets" "private_subnet" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.selected.id}"]
  }

  tags = {
    SUB-Type = "Private"
  }
}

data "aws_security_group" "vpn_sg" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "client-vpn-sg-vpc-*"
  }
}
