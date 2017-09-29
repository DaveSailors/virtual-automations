# deployAmiSpack
Spins up a running instance from the standard AWS Linux ami and runs a script using the user_data facility    
 - the script "userdata.sh" is setup to install git then
 	- clone the spack repo into /opt/spack
 	- install a couple of modules
        - sets the path statement for root




how to access your instance on amazon:

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html?icmpid=docs_ec2_console



### Spack

https://github.com/LLNL/spack

    Todd Gamblin, Matthew P. LeGendre, Michael R. Collette, Gregory L. Lee, Adam Moody, Bronis R. de Supinski, and W. Scott Futral. The Spack Package Manager: Bringing Order to HPC Software Chaos. In Supercomputing 2015 (SC’15), Austin, Texas, November 15-20 2015. LLNL-CONF-669890.

