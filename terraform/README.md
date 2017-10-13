# terraform modules

### Installing Terraform

https://www.terraform.io/intro/getting-started/install.html

### to run deployami from the command line


terraform init  -var 'ami_id=<your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <p> <path-to-module> </p>
terraform plan  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <p> <path-to-module> </p>
terraform apply  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' <p>i <path-to-module> </p>


