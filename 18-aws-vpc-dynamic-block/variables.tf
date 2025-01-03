variable "ports" {
  description = "Ports to be opened on Security Group"
  type = map(object({
    description = string
    cidr_block  = list(string)
  }))
  default = {
    22 = {
      description = "Port 22 for VPN"
      cidr_block  = ["20.15.101.158/32"]
    }
    80 = {
      description = "Port 80 for Internet"
      cidr_block  = ["0.0.0.0/0"]
    }
    443 = {
      description = "Port 443 for Internet"
      cidr_block  = ["0.0.0.0/0"]
    }
  }
}