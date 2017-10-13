# CreateSpackAmi


### a Packer module

creates a peronal ami from any source linux ami and preloads it with spack  

 - runs yum update   
 - installs git    
 - creates a spack Linux ID    
 - clones llnl/spack as the user spack in the spack home folder     
 - executes a spack command. 
 - it could setup config files and install packages at this point     

