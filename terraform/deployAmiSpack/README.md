# deployAmiSpack
Spins up a running instance from the standard AWS Linux ami and runs a script using the user_data facility    
 - the script "userdata.sh" is setup to install git then
 	- clone the spack repo into /opt/spack
 	- install a couple of modules
        - sets the path statement for root


