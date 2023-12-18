


resource "aws_subnet" "proje2_public_subnet" {
  count = 2
  vpc_id = aws_vpc.proje2_vpc.id
  cidr_block = count.index == 0 ? "90.90.10.0/24" : "90.90.20.0/24"
  availability_zone = count.index == 0 ? "us-east-1a" : "us-east-1b"
  tags = {
    Name = count.index == 0 ? "proje2-public-subnet-1A" : "proje2-public-subnet-1B"
  }
  map_public_ip_on_launch = true # Bu satırı ekleyerek public IP otomatik atanmasını sağlayabilirsiniz
}

resource "aws_subnet" "proje2_private_subnet" {
  count = 2
  vpc_id = aws_vpc.proje2_vpc.id
  cidr_block = count.index == 0 ? "90.90.11.0/24" : "90.90.21.0/24"
  availability_zone = count.index == 0 ? "us-east-1a" : "us-east-1b"
  tags = {
    Name = count.index == 0 ? "proje2-private-subnet-1A" : "proje2-private-subnet-1B"
  }
}








# resource "aws_subnet" "proje2_public_subnet_1A" {
#   vpc_id     = aws_vpc.proje2_vpc.id
#   cidr_block = "90.90.10.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "proje2-public-subnet-1A"
#   }
#   map_public_ip_on_launch = true                            ## Public Ip atanmasi icin
# }

# resource "aws_subnet" "proje2_private_subnet_1A" {
#   vpc_id     = aws_vpc.proje2_vpc.id
#   cidr_block = "90.90.11.0/24"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name = "proje2-private-subnet-1A"
#   }
# }

# resource "aws_subnet" "proje2_public_subnet_1B" {
#   vpc_id     = aws_vpc.proje2_vpc.id
#   cidr_block = "90.90.20.0/24"
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "proje2-public-subnet-1B"
#   }
#   map_public_ip_on_launch = true                            ## Public Ip atanmasi icin
# }

# resource "aws_subnet" "proje2_private_subnet_1B" {
#   vpc_id     = aws_vpc.proje2_vpc.id
#   cidr_block = "90.90.21.0/24"
#   availability_zone = "us-east-1b"
#   tags = {
#     Name = "proje2-private-subnet-1B"
#   }
# }