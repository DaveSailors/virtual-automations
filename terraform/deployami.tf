provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-de6a5dbe"
  instance_type = "t2.micro"
}

