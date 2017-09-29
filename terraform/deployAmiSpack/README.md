# deployAmiSpack
Spins up a running instance from the standard AWS Linux ami and runs a script using the user_data facility    
 - the script "userdata.sh" is setup to install git then
 	- clone the spack repo into /opt/spack
 	- install a couple of modules
        - sets the path statement for root



Warning

Don't Proceed without a key pair. If you launch your instance without a key pair association, then you can't connect to it.

	From the EC2 console, select Key Pairs under Network & Security
	click on Create Key Pair
	name the key pair
	download the private key to your desktop or where ever you want to access the instance from
	you may need to convert it from .pem to .ppk to use some ssh clients


### how to access your instance on amazon

  putty -
	https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console


### Spack

developed and hosted by Lawrence Livermore National Laboratory 
https://www.llnl.gov/

https://github.com/LLNL/spack

Todd Gamblin, Matthew P. LeGendre, Michael R. Collette, Gregory L. Lee, Adam Moody, Bronis R. de Supinski, and W. Scott Futral. The Spack Package Manager: Bringing Order to HPC Software Chaos. In Supercomputing 2015 (SC’15), Austin, Texas, November 15-20 2015. LLNL-CONF-669890.

