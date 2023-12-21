

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

resource "aws_iam_role_policy_attachment" "attach_S3_policy" {
  role       = aws_iam_role.proje2_EC2_S3_Full_Access.name
  policy_arn = aws_iam_policy.proje2_S3_Full_Access_Policy.arn
}

resource "aws_iam_instance_profile" "proje2_iam_profile" {
  name = "role_profile"
  role = aws_iam_role.proje2_EC2_S3_Full_Access.name
}

resource "aws_iam_policy" "proje2_S3_Full_Access_Policy" {
  name        = "proje2_S3_Full_Access_Policy"
  description = "Policy for full access to S3"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "s3:*",
      Resource  = "*"  # Tüm kaynaklara erişim için; daha spesifik bir kaynak belirtmek daha güvenli olabilir
    }]
  })
}








# IAM Role oluşturma   ##Sadece burasi vardi


# resource "aws_iam_role" "proje2_EC2_S3_Full_Access" {
#   name        = "proje2_EC2_S3_Full_Access"
#   description = "For EC2, S3 Full Access Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }

# resource "aws_iam_instance_profile" "proje2_iam_profile" {
#   name = "role_profile"
#   role = aws_iam_role.proje2_EC2_S3_Full_Access.name
# }











## Bu kisim duruyoordu


# resource "aws_iam_policy" "sns_access_policy" {
#   name        = "sns-access-policy"
#   description = "Policy for SNS access"
  
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Action    = [
#         "sns:Publish",
#         "sns:Subscribe",
#         "sns:Receive"
#       ],
#       Resource  = "*"  # Tüm SNS kaynaklarına erişim için "*" kullanılabilir, ancak güvenlik açısından daha spesifik bir ARN tercih edilebilir
#     }]
#   })
# }

# resource "aws_iam_policy_attachment" "attach_sns_access_policy" {
#   name       = "attach-sns-access-policy"
#   roles      = [aws_iam_role.proje2_EC2_S3_Full_Access.name]
#   policy_arn = aws_iam_policy.sns_access_policy.arn
# }

# resource "aws_sns_topic" "proje2_topic" {
#   name = "proje2_topic"
# }

# resource "aws_sns_topic_subscription" "proje2_topic_subscription" {
#   topic_arn = aws_sns_topic.proje2_topic.arn
#   protocol  = "email"
#   endpoint  = "mat.aksoy06@gmail.com"
# }









# resource "aws_iam_role" "proje2_EC2_S3_Full_Access" {
#   name        = "proje2_EC2_S3_Full_Access"
#   description = "For EC2, S3 Full Access Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       },
#       Action    = "sts:AssumeRole"
#     }]
#   })
# }



# resource "aws_iam_instance_profile" "proje2_iam_profile" {
#   name = "role_profile"
#   role = aws_iam_role.proje2_EC2_S3_Full_Access.name
# }


# resource "aws_iam_role_policy_attachment" "attach_s3_full_access" {
#   role       = aws_iam_role.proje2_EC2_S3_Full_Access.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }


# IAM Policy ata  
# resource "aws_iam_policy_attachment" "attach_s3_full_access" {
#   name       = "s3-full-access"
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
#   roles      = [aws_iam_role.proje2_EC2_S3_Full_Access.name]
# }
