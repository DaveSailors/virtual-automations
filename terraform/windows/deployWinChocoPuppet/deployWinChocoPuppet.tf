provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "us-west-1"
}


resource "aws_instance" "Choco" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "HomeWindows"
  security_groups = [
    "launch-wizard-1",
    "SG-Home-Open"
    ]


  user_data = "${file("virtual-automations/terraform/windows/deployWinChocoPuppet/userdata.bat")}"
}

