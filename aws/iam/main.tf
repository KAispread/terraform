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

# iam user - IAM user
resource "aws_iam_user" "developer1" {
    name = "developer1"
    path = "/system/"
}

# iam group -> 권한 그룹
resource "aws_iam_group" "developer_group" {
    name = "developer"
    path = "/system/"
}

# 권한 그룹과 IAM 유저 매핑
resource "aws_iam_group_membership" "developer_membership" {
    name = "developer_membership"

    users = [
        aws_iam_user.developer1.name,
    ]

    group = aws_iam_group.developer_group.name
}

# 권한 정책 정의
resource "aws_iam_policy" "developer_policy" {
    name = "developer_policy"
    path = "/system/"
    description = "developer policy"
  
    # Heredoc syntax
    policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "s3:ListAllMyBuckets"
                ],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
    }
    EOF
}

# 권한 그룹에 정책 매핑
resource "aws_iam_group_policy_attachment" "developer_group_policy_attachment" {
    group = aws_iam_group.developer_group.name
    policy_arn = aws_iam_policy.developer_policy.arn
}
