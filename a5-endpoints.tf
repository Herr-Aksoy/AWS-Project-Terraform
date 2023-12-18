
resource "aws_vpc_endpoint" "proje2_ep" {
  vpc_id            = aws_vpc.proje2_vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"

#   policy = jsonencode({           #Burada bir policy yapilmasi lazim bence ama 
#     "Statement": [                # Bu sekilde ayaga kalkti. Eger en son olmazsa ayarcek.
#       {
#         "Action": [
#           "s3:GetObject",
#           "s3:PutObject"
#         ],
#         "Effect": "Allow",
#         "Resource": "*"
#       }
#     ]
#   })

  route_table_ids = [aws_route_table.proje2_private_rt.id]
  tags = {
    Name = "proje2-EP"
  }
}






# resource "aws_vpc_endpoint" "proje2_ep" {
#   vpc_id            = aws_vpc.proje2_vpc.id
#   service_name      = "com.amazonaws.us-east-1.s3"
#   vpc_endpoint_type = "Gateway"

#   policy = jsonencode({
#     "Statement" : [
#       {
#         "Action"   : "s3:*",
#         "Effect"   : "Allow",
#         "Resource" : "*"
#       }
#     ]
#   })

#   route_table_ids = [aws_route_table.proje2_private_rt.id]
#   tags = {
#     Name = "proje2-EP"
#   }
# }




# resource "aws_vpc_endpoint" "proje2_ep" {
#   vpc_id            = aws_vpc.proje2_vpc.id
#   service_name      = "com.amazonaws.us-east-1.s3"
#   vpc_endpoint_type = "Gateway"

#   policy = <<POLICY
# {
#   "Statement": [
#     {
#       "Action": "*",
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# POLICY

#   route_table_ids = [aws_route_table.proje2_private_rt.id]  # İlgili route table'ları belirtmek gerekli
#   tags = {
#     Name = "proje2-EP"
#   }
# }







