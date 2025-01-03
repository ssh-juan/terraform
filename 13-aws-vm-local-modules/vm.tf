resource "aws_key_pair" "key" {
  key_name   = "aws-key-${var.environment}"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-015f3596bb2ef1aaa" #Ubuntu Server 24.04 LTS
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = module.network.subnet_id            #retrieved info from module
  vpc_security_group_ids      = [module.network.security_group_id]  #retrieved info from module
  associate_public_ip_address = true

  tags = {
    Name = "vm-${var.environment}"
  }
}