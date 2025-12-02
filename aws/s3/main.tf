terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
    region = "ap-northeast-2"
}

# bucket 생성
resource "aws_s3_bucket" "learn-terraform-mybucket" {
    bucket = "learn-terraform-mybucket-ex-2"

    tags = {
        environment = "devel"
    }
}

# public access 허용 
resource "aws_s3_bucket_public_access_block" "public-access" {
    bucket = aws_s3_bucket.learn-terraform-mybucket.id
    
    block_public_acls = false
    block_public_policy = false
    ignore_public_acls = false
    restrict_public_buckets = false
}

# aws s3 object
resource "aws_s3_object" "learn-terraform-sample-txt" {
    bucket = aws_s3_bucket.learn-terraform-mybucket.id
    key = "aws_image"
    source = "AWS.jpeg"
}

# bucket 정책 생성
resource "aws_s3_bucket_policy" "bucket-policy" {
    bucket = aws_s3_bucket.learn-terraform-mybucket.id

    depends_on = [ aws_s3_bucket_public_access_block.public-access ]
    
    policy = <<POLICY
    {
        "Version":"2012-10-17",
        "Statement":[
            {
                "Sid":"PublicRead",
                "Effect":"Allow",
                "Principal": "*",
                "Action":["s3:GetObject"],
                "Resource":["arn:aws:s3:::${aws_s3_bucket.learn-terraform-mybucket.id}/*"]
            }
        ]
    }
    POLICY
}
