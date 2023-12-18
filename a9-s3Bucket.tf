

resource "aws_s3_bucket" "proje2blog" {
  bucket        = "proje2blog"
  force_destroy = true
}

resource "aws_s3_bucket" "proje2_awspublic_link" {
  bucket        = "proje2.awspublic.link"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "example_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_ownership_controls" "example_blog" {
  bucket = aws_s3_bucket.proje2blog.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "example_blog" {
  bucket = aws_s3_bucket.proje2blog.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_awspublic_link" {
  bucket       = aws_s3_bucket.proje2_awspublic_link.id
  key          = "index.html"
  source       = "./s3_Website/index.html"
  etag         = filemd5("./s3_Website/index.html")
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "sorry_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id
  key    = "sorry.jpg"
  source = "./s3_Website/sorry.jpg"
  etag   = filemd5("./s3_Website/sorry.jpg")
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "failover_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id

  index_document {
    suffix = "index.html"
  }
}

output "s3_bucket_website_endpoint_awspublic_link" {
  value       = aws_s3_bucket_website_configuration.failover_awspublic_link.website_endpoint 
  description = "The website endpoint URL for proje2.awspublic.link"
}






# resource "aws_s3_bucket" "proje2blog" {
#   bucket = "proje2blog"
#   force_destroy = true
# }



# # Bekir abinin file


# resource "aws_s3_bucket" "proje2_awspublic_link" {
#   bucket        = "proje2.awspublic.link"
#   force_destroy = true #default false
# }
# resource "aws_s3_bucket_ownership_controls" "example" {
#   bucket = [
#     aws_s3_bucket.proje2_awspublic_link.id,
#     aws_s3_bucket.proje2blog.id
#   ]
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket = [
#     aws_s3_bucket.proje2_awspublic_link.id,
#     aws_s3_bucket.proje2blog.id,
#   ]

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_acl" "example" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.example,
#     aws_s3_bucket_public_access_block.example,
#     aws_s3_bucket.proje2_awspublic_link,                 ## hata buradan geliyor sanki
#   ]
#   bucket = [
#   aws_s3_bucket.proje2_awspublic_link.id,
#   aws_s3_bucket.proje2blog.id,
#   ]
#   acl    = "private" #private for not public read
# }

# resource "aws_s3_object" "index" {
#   bucket       = "proje2.awspublic.link"
#   key          = "index.html"
#   source       = "./s3_Website/index.html"
#   etag         = filemd5("./s3_Website/index.html")
#   acl          = "public-read"
#   content_type = "text/html"
#   depends_on   = [aws_s3_bucket.proje2_awspublic_link]
# }

# resource "aws_s3_object" "sorry" {
#   bucket = "proje2.awspublic.link"
#   key    = "sorry.jpg"
#   source = "./s3_Website/sorry.jpg"
#   etag   = filemd5("./s3_Website/sorry.jpg")
#   acl    = "public-read"

#   depends_on = [aws_s3_bucket.proje2_awspublic_link]
# }

# resource "aws_s3_bucket_website_configuration" "failover" {
#   bucket = aws_s3_bucket.proje2_awspublic_link.id
#   depends_on = [ aws_s3_bucket_ownership_controls.example ]               # Bunu ekledim hata bundan geliyor olabilir.

#   index_document {
#     suffix = "index.html"
#   }
# }


# output "s3_bucket_website_endpoint" {
#   depends_on = [ aws_s3_bucket.proje2.awspublic.link ]
#   value       = aws_s3_bucket_website_configuration.failover.website_endpoint 
#   description = "The website endpoint URL"
# }






# BU kisim ayri


# resource "aws_s3_bucket" "proje2blog" {
#   bucket = "proje2blog"
# }

# resource "aws_s3_bucket_website_configuration" "dosya_yazma" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   index_document {
#     suffix = "index.html"
#   } 
# }

# resource "aws_s3_bucket_public_access_block" "proje2_devopstricks_link" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket" "proje2_devopstricks_link" {
#   bucket = "proje2.devopstricks.link"
#   acl    = "public-read"
# }

# resource "aws_s3_object" "index_html" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "index.html"
#   source = "./s3_Website/index.html"
#   acl    = "public-read"
# }



# resource "aws_s3_object" "sorry_jpg" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "sorry.jpg"
#   source = "./s3_Website/sorry.jpg"
#   acl    = "public-read"
# }






# BU kisim farkli



# resource "aws_s3_bucket_ownership_controls" "example" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   rule {
#     object_ownership = "BucketOwnerEnforced"
#   }
# }


# resource "aws_s3_bucket_acl" "example" {
#   # depends_on = [
#   #   aws_s3_bucket_ownership_controls.example,
#   #   aws_s3_bucket_public_access_block.example,
#   # ]

#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   acl    = "public-read"
# }








# resource "aws_s3_bucket_policy" "proje2_devopstricks_link_policy" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   policy = jsonencode({
#     Version   = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = "*",
#       Action    = "s3:GetObject",
#       Resource  = "${aws_s3_bucket.proje2_devopstricks_link.arn}/*",
#       Condition = {
#         StringLike = {
#           "aws:Referer": [
#             "http://devopstricks.link/*",
#             "https://devopstricks.link/*"
#           ]
#         }
#       }
#     }]
#   })
# }

















# resource "aws_s3_bucket" "proje2blog" {
#   bucket = "proje2blog"
#   #acl    = "private"
# }

# resource "aws_s3_bucket" "proje2_devopstricks_link" {
#   bucket = "proje2.devopstricks.link"
#   #acl    = "private"
# }

# resource "aws_s3_object" "index_html" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "index.html"
#   source = "./s3_Website/index.html"
#   acl    = "public-read"
# }

# resource "aws_s3_object" "sorry_jpg" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "sorry.jpg"
#   source = "./s3_Website/sorry.jpg"
#   acl    = "public-read"
# }

# resource "aws_s3_bucket_public_access_block" "proje2_devopstricks_link" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "proje2_devopstricks_link_policy" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = "*",
#       Action    = "s3:GetObject",
#       Resource  = "${aws_s3_bucket.proje2_devopstricks_link.arn}/*",
#       Condition = {
#         StringLike = {
#           "aws:Referer": ["http://devopstricks.link/*", "https://devopstricks.link/*"]
#         }
#       }
#     }]
#   })
# }











# ./s3_Website/sorry.jpg

#./s3_Website/index.html

# resource "aws_s3_bucket" "proje2blog" {
#   bucket = "proje2blog"
# }

# resource "aws_s3_bucket" "proje2_devopstricks_link" {
#   bucket = "proje2.devopstricks.link"
# }

# resource "aws_s3_bucket_public_access_block" "proje2_devopstricks_link" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }



# resource "aws_s3_object" "index_html" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "index.html"
#   source = "./s3_Website/index.html"
#   acl    = "private"
# }



# resource "aws_s3_object" "sorry_jpg" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "sorry.jpg"
#   source = "./s3_Website/sorry.jpg"
#   acl    = "private"
# }

# resource "aws_s3_bucket_policy" "proje2_devopstricks_link_policy" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   policy = jsonencode({
#     Version   = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = "*",
#       Action    = "s3:GetObject",
#       Resource  = "${aws_s3_bucket.proje2_devopstricks_link.arn}/*",
#       Condition = {
#         StringLike = {
#           "aws:Referer": [
#             "http://devopstricks.link/*",
#             "https://devopstricks.link/*"
#           ]
#         }
#       }
#     }]
#   })
# }

















# resource "aws_s3_bucket" "proje2blog" {
#   bucket = "proje2blog"
#   #acl    = "private"
# }

# resource "aws_s3_bucket" "proje2_devopstricks_link" {
#   bucket = "proje2.devopstricks.link"
#   #acl    = "private"
# }

# resource "aws_s3_object" "index_html" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "index.html"
#   source = "./s3_Website/index.html"
#   acl    = "public-read"
# }

# resource "aws_s3_object" "sorry_jpg" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id
#   key    = "sorry.jpg"
#   source = "./s3_Website/sorry.jpg"
#   acl    = "public-read"
# }

# resource "aws_s3_bucket_public_access_block" "proje2_devopstricks_link" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# resource "aws_s3_bucket_policy" "proje2_devopstricks_link_policy" {
#   bucket = aws_s3_bucket.proje2_devopstricks_link.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect    = "Allow",
#       Principal = "*",
#       Action    = "s3:GetObject",
#       Resource  = "${aws_s3_bucket.proje2_devopstricks_link.arn}/*",
#       Condition = {
#         StringLike = {
#           "aws:Referer": ["http://devopstricks.link/*", "https://devopstricks.link/*"]
#         }
#       }
#     }]
#   })
# }



