

# IAM Role oluşturma
resource "aws_iam_role" "proje2_EC2_S3_Full_Access" {
  name        = "proje2_EC2_S3_Full_Access"
  description = "For EC2, S3 Full Access Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# IAM Policy ata  
# resource "aws_iam_policy_attachment" "attach_s3_full_access" {
#   name       = "s3-full-access"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   roles      = [aws_iam_role.proje2_EC2_S3_Full_Access.name]
# }

resource "aws_iam_instance_profile" "proje2_iam_profile" {
  name = "role_profile"
  role = aws_iam_role.proje2_EC2_S3_Full_Access.name
}


resource "aws_iam_role_policy_attachment" "attach_s3_full_access" {
  role       = aws_iam_role.proje2_EC2_S3_Full_Access.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}


