#!/bin/bash
date >/tmp/userdata.log
echo Hello >>/tmp/userdata.log
yum list | grep git >> /tmp/userdata.log
yum -y install git.x86_64 >>/tmp/userdata.log
yum list | grep git >>/tmp/userdata.log
git help >>/tmp/userdata.log

