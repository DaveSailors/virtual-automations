provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-west-1"
}


resource "aws_instance" "example" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "AWS_Auto"
  user_data = "${file("userdata.sh")}"
}

