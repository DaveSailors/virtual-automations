#!/bin/bash
echo "***********************************" >>/tmp/userdata.log 2>&1
date >/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
echo ...userdata.sh starting... >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
sudo yum -y update >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
sudo yum -y install git.x86_64 >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
git help >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
sudo mkdir /opt/spack >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
cd /opt/spack >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
sudo git clone https://github.com/LLNL/spack.git >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
sudo /opt/spack/spack/bin/spack >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1
date >>/tmp/userdata.log 2>&1
echo ...userdata.sh endinging... >>/tmp/userdata.log 2>&1
echo "***********************************" >>/tmp/userdata.log 2>&1


