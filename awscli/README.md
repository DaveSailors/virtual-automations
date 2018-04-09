# AWS Command Line Interface


##VPC-with-Bastion.pl

An AWS cli script that creates a vpc in a specified region and
 - creates a Linux Bastion host in the vpc 
 - creates access keys for the host and drops the private key file(.pem) in the run time directory
 - creates an elastic IP (public address) for the Bastion to listen on. 


To connect to the Bastion Instance:

1. From the AWS EC2 user interface select the instance and click on the connect button
   - Click on the "Connect" button at the top
     - copy/paste the ssh command into your work space at the Linux command line and hit <ENTER>
     - it will use the .pem key file created by the script to authenticate you


