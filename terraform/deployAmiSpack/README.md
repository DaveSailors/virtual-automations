# deployAmiSpack
Spins up a running instance from the standard AWS Linux ami and runs a script using the user_data facility    
 - the script "userdata.sh" is setup to install git then
 	- clone the spack repo into /opt/spack
 	- install a couple of modules
        - sets the path statement for root



Warning

Don't select the Proceed without a key pair option. If you launch your instance without a key pair, then you can't connect to it.

### how to access your instance on amazon


https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console


### Spack

developed and hosted by Lawrence Livermore National Laboratory 
https://www.llnl.gov/

https://github.com/LLNL/spack

    Todd Gamblin, Matthew P. LeGendre, Michael R. Collette, Gregory L. Lee, Adam Moody, Bronis R. de Supinski, and W. Scott Futral. The Spack Package Manager: Bringing Order to HPC Software Chaos. In Supercomputing 2015 (SC’15), Austin, Texas, November 15-20 2015. LLNL-CONF-669890.

