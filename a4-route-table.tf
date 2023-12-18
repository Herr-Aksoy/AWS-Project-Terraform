
resource "aws_route_table" "proje2_public_rt" {
  vpc_id = aws_vpc.proje2_vpc.id
  tags = {
    Name = "proje2-public-RT"
  }
}

resource "aws_route" "public_subnet_route" {                ## Bura Route table altinda da belirtile bilir
  count = length(aws_subnet.proje2_public_subnet.*.id)      ## ilkprojedeki gibi ama bu tarz daha esnek oluyor
  route_table_id = aws_route_table.proje2_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.proje2_igw.id
}

resource "aws_route_table" "proje2_private_rt" {
  vpc_id = aws_vpc.proje2_vpc.id
  tags = {
    Name = "proje2-private-RT"
  }
}

# Özel route table'a route ekleme
# resource "aws_route" "nat_instance_route" {
#   route_table_id         = aws_route_table.proje2_private_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   instance_id            = aws_instance.nat_instance.id
#   depends_on = [ aws_instance.nat_instance ]
# }






resource "aws_route_table_association" "public_subnet_association" {
  count = length(aws_subnet.proje2_public_subnet.*.id)
  subnet_id = aws_subnet.proje2_public_subnet[count.index].id
  route_table_id = aws_route_table.proje2_public_rt.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count = length(aws_subnet.proje2_private_subnet.*.id)
  subnet_id = aws_subnet.proje2_private_subnet[count.index].id
  route_table_id = aws_route_table.proje2_private_rt.id
}



