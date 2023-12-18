



resource "aws_internet_gateway" "proje2_igw" {
  vpc_id = aws_vpc.proje2_vpc.id
  tags = {
    Name = "proje2-IGW"
  }
}


