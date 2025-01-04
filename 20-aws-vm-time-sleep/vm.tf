resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}

resource "aws_instance" "vm_1" {
  ami                         = "ami-015f3596bb2ef1aaa" #Ubuntu Server 24.04 LTS
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id           #retrieved info from .tfstate of vpc
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id] #retrieved info from .tfstate of vpc
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform-1"
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.vm_1]

  create_duration  = "30s"
  destroy_duration = "20s"
}

resource "aws_instance" "vm_2" {
  depends_on = [time_sleep.wait_30_seconds]

  ami                         = "ami-015f3596bb2ef1aaa" #Ubuntu Server 24.04 LTS
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id           #retrieved info from .tfstate of vpc
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.security_group_id] #retrieved info from .tfstate of vpc
  associate_public_ip_address = true

  tags = {
    Name = "vm-terraform-2"
  }
}