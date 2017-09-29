#!/bin/bash
date >/tmp/userdata.log
echo ...userdata.sh startingxi... >>/tmp/userdata.log
sudo yum -y install git.x86_64 >>/tmp/userdata.log
git help >>/tmp/userdata.log

