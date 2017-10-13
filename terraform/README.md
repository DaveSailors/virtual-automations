# terraform modules

Installing Terraform

https://www.terraform.io/intro/getting-started/install.html

to run deployami from the command line


terraform init  -var 'ami_id=<your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <path-to-module>
terraform plan  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <path-to-module>
terraform apply  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <path-to-module>


