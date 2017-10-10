# deployAmiSpack - (a terraform module)
Spins up a running instance from the standard AWS Linux ami and runs a script using the user_data facility    
 - the script "userdata.sh" is setup to        
 	- run yum update     
 	- install git     
 	- clone the spack repo into /opt/spack as root    
 	- install a couple of modules    


### You'll need a key pair

<b><i>If you launch your instance without a key pair association, then you can't connect to it</i>!</b>

- From the EC2 console, select Key Pairs under Network & Security
- click on Create Key Pair
- name the key pair 
	- the key name will be what you enter in the <b> key_name </b> field under the <b> resource "aws_instance" "Spack" </b> declaration
- download the private key to your desktop or where ever you want to access the instance from. You will need it for the ssh client
- you may need to convert it from .pem to .ppk to use some ssh clients. See putty link below for connecting with ssh


### how to access your instance on amazon

The default ID of any instance you create will re-use the default ID from the source ami. Here I'm using the default AWS linux ami (as seen in the create instance wizard from the EC2 console).
So the instance created by this terraform module default user ID will be <b> ec2-user </b>

  putty -
	https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console


### Spack

developed and hosted by Lawrence Livermore National Laboratory 
https://www.llnl.gov/

https://github.com/LLNL/spack

Todd Gamblin, Matthew P. LeGendre, Michael R. Collette, Gregory L. Lee, Adam Moody, Bronis R. de Supinski, and W. Scott Futral. The Spack Package Manager: Bringing Order to HPC Software Chaos. In Supercomputing 2015 (SC’15), Austin, Texas, November 15-20 2015. LLNL-CONF-669890.

