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

resource "aws_ssm_parameter" "db_username" {
    name = "/myapp/config/db_username"
    type = "String"
    value = "admin"
    description = "The database username for my app"
}

resource "aws_ssm_parameter" "db_password" {
    name = "/myapp/config/db_password"
    // store value with encryption
    type = "SecureString"
    value = "super_secret_password"
    description = "The database password for my app"
}

data "aws_ssm_parameter" "db_username" {
    name = "/myapp/config/db_username"

    depends_on = [ aws_ssm_parameter.db_username ]
}

output "db_username_value" {
    value = data.aws_ssm_parameter.db_username.value
    sensitive = true
}

data "aws_ssm_parameter" "db_password" {
    name = "/myapp/config/db_password"
    with_decryption = true

    depends_on = [ aws_ssm_parameter.db_password ]
}

output "db_password" {
    value = data.aws_ssm_parameter.db_password.value
    sensitive = true
}