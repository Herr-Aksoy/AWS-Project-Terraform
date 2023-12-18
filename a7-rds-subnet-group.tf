

resource "aws_db_subnet_group" "proje2_RDS_Subnet_Group" {
  name        = "proje2-rds-subnet-group"
  description = "proje2_RDS_Subnet_Group"
  subnet_ids  = [
    aws_subnet.proje2_private_subnet[0].id,
    aws_subnet.proje2_private_subnet[1].id,
  ]
  tags = {
    Name = "proje2_RDS_Subnet_Group"
  }
}
