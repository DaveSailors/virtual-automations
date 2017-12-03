# terraform modules -  AWS provider

### deployWinChocoPuppet

Deploy an AWS supplied Windows ami and pass a script to:

 - run a powershell command that will install the choco client from chocolatey.org.

 - using chocolatey ( choco -? ) install the puppet-agent puppet module from the chocolatey gallery also at chocolatey.org.
   - multiple options can be added when installing the puppet-agent package, including puppet master, puppet CA server, a  
     puppet agent cert name, environment, and others

 


