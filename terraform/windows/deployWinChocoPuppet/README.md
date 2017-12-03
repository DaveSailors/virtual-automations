# terraform modules -  AWS provider

### deployWinChocoPuppet

Deploy an AWS supplied Windows ami and pass a script to:

 - run a powershell command that will install the choco client from chocolatey.org.

 - using chocolatey ( choco -? ) install the puppet-agent puppet module from the chocolatey gallery also at chocolatey.org.
   - multiple options can be added when installing the puppet-agent package, including puppet master, puppet CA server, puppet agent cert name, environment. 
     https://chocolatey.org/packages/puppet-agent   
   

  Install Options

    You can pass installArgs to Chocolatey for several properties. See http://docs.puppetlabs.com/puppet/latest/reference/install_windows.html#msi-properties for the exact properties. You would pass through the arguments to the installer using 'installArgs'. Here is an example of changing the location of the Puppet Master:

     -installArgs '"PUPPET_MASTER_SERVER=puppet.fqdn.com"'
 


