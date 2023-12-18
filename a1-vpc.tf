

resource "aws_vpc" "proje2_vpc" {
  cidr_block       = "90.90.0.0/16"
  enable_dns_support = true                    ## Bu olmasada olur sanki
  enable_dns_hostnames = true               ## VPC icerisinde bütün resourcelarin birbiri ile göresebilmeleri icin.
  
  tags = {
    Name = "proje2-vpc"
  }
}







