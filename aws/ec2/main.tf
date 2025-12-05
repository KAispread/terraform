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

data "aws_ami" "ubuntu" {
    # most_recent - (Optional) If more than one result is returned, use the most recent AMI.
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = [ "hvm" ]
    }

    owners = ["099720109477"]
}

# aws ec2 create-default-subnet --availability-zone ap-northeast-2
resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"

    tags = {
       Name = "Helloworld"
    }
}
