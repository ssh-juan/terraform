resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm" {
  ami                         = "ami-015f3596bb2ef1aaa" #Ubuntu Server 24.04 LTS
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id           #retrieved info from .tfstate of vpc
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id] #retrieved info from .tfstate of vpc
  associate_public_ip_address = true

  lifecycle {
    replace_triggered_by = [ aws_s3_bucket.bucket ]
  }

  tags = {
    Name = "vm-terraform"
  }
}