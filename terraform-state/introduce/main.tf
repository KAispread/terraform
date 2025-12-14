provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "web" {
  ami = "ami-02578e837ff5e6b4a"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}