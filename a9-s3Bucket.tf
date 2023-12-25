

resource "aws_s3_bucket" "proje2blog" {
  bucket        = "proje2blog"
  force_destroy = true
}

resource "aws_s3_bucket" "proje2_awspublic_link" {
  bucket        = "proje2.awspublic.link"
  # depends_on = [ aws_s3_bucket.proje2blog ]
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "example_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id
  depends_on = [ aws_s3_bucket_ownership_controls.example_blog ]

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_ownership_controls" "example_blog" {
  bucket = aws_s3_bucket.proje2blog.id
  # depends_on = [ aws_s3_bucket.proje2blog ]

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id
  depends_on = [ aws_s3_bucket_ownership_controls.example_blog ]

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "example_blog" {
  bucket = aws_s3_bucket.proje2blog.id
  depends_on = [ aws_s3_bucket_ownership_controls.example_awspublic_link ]

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_awspublic_link" {
  bucket       = aws_s3_bucket.proje2_awspublic_link.id
  depends_on = [ aws_s3_bucket_website_configuration.failover_awspublic_link ]
  key          = "index.html"
  source       = "./s3_Website/index.html"
  etag         = filemd5("./s3_Website/index.html")
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "sorry_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id
  depends_on = [ aws_s3_bucket_website_configuration.failover_awspublic_link ]
  key    = "sorry.jpg"
  source = "./s3_Website/sorry.jpg"
  etag   = filemd5("./s3_Website/sorry.jpg")
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "failover_awspublic_link" {
  bucket = aws_s3_bucket.proje2_awspublic_link.id
  depends_on = [ aws_s3_bucket_ownership_controls.example_awspublic_link ]

  index_document {
    suffix = "index.html"
  }
}

output "s3_bucket_website_endpoint_awspublic_link" {
  value       = aws_s3_bucket_website_configuration.failover_awspublic_link.website_endpoint 
  description = "The website endpoint URL for proje2.awspublic.link"
}










