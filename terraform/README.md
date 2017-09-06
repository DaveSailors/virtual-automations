# terraform mods


to run deployami from the command line

```   
git clone https://github.com/DaveSailors/virtual-automations.git

/usr/local/bin/terraform init  -var 'ami_id=<your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' virtual-automations/terraform/deployami
/usr/local/bin/terraform plan  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' virtual-automations/terraform/deployami
/usr/local/bin/terraform apply  -var 'ami_id=<Your ami>' -var 'access_key=<your aws key>' -var 'secret_key=<your aws secret key>' virtual-automations/terraform/deployami
```   


where 
<your ami>  is the source ami id, like ami-de6a5dbe

<your aws key>  is the AWS access key or ID your using for the script. see IAM console to create one.

and 
<your aws secret key> is the secret key for the access key. 



