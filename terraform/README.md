# terraform modules

### Installing Terraform

https://www.terraform.io/intro/getting-started/install.html

### to run deployami from the command line


terraform init  -var 'ami_id=<b>your ami</b>' -var 'access_key=<b>your aws key</b>' -var 'secret_key=<b>your aws secret key</b>' <b>path-to-module</b>
terraform plan  -var 'ami_id=<b>Your ami</b>' -var 'access_key=<b>your aws key</b>' -var 'secret_key=<b>your aws secret key</b>' <b>path-to-module</b>
terraform apply  -var 'ami_id=<b>Your ami</b>' -var 'access_key=<b>your aws key</b>' -var 'secret_key=<b>your aws secret key</b>' <b>path-to-module</b>


