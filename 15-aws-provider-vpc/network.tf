resource "aws_subnet" "brazil" {
  vpc_id     = module.vpc.vpc_id_default
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-terraform-provider"
  }
}

resource "aws_subnet" "usa" {
  provider = aws.usa

  vpc_id     = module.vpc.vpc_id_provider_1
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-terraform-provider"
  }
}

resource "aws_subnet" "australia" {
  provider = aws.australia

  vpc_id     = module.vpc.vpc_id_provider_2
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-terraform-provider"
  }
}
