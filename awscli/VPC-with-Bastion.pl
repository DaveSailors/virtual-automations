#!/usr/bin/perl

#--------------------

$region = "us-west-1";

#--------------------

# - VPC definition:

$vpcName = "AutoGenVPC";

$vpcCIDR = "155.14.0.0/16";
$subnet1CIDR = "155.14.1.0/24";
$subnet2CIDR = "155.14.5.0/24";


# Create the VPC
#-----

$vpcCreateCmd = "aws ec2 create-vpc --output json --cidr-block $vpcCIDR --region $region";
print "$vpcCreateCmd \n";

@return = `$vpcCreateCmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"VpcId\"\:") > 0) || (index($return[$i],"\"State\"\:") > 0) || (index($return[$i],"\"InstanceTenancy\"\:") > 0) || (index($return[$i],"\"DhcpOptionsId\"\:") > 0) || (index($return[$i],"\"CidrBlock\"\:") > 0) || (index($return[$i],"\"IsDefault\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $vpc{$record[0]} = $record[1];
           $vpc{$record[0]}=~ s/ //g;

        }
  }

# Put the VPCid in the name of the bastion host key
$Bastion{keyname} = "Bastion-$vpc{VpcId}";
#------------------------------------

# Tag the VPC
#-----

$TagVpcCmd = "aws ec2 create-tags --resources $vpc{VpcId} --tags Key=Name,Value=$vpcName --output json --region $region";
print "$TagVpcCmd\n";

@return = `$TagVpcCmd`;
for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print " - $return[$i]\n";
  }

#------------------------------------

print "\n";


# Create Subnets
#-----
print "Create subnet1 \n";

$CreateSubnet1Cmd = "aws ec2 create-subnet --vpc-id $vpc{VpcId} --cidr-block $subnet1CIDR --output json --region $region";
print "$CreateSubnet1Cmd \n";

#-----
@return = `$CreateSubnet1Cmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"VpcId\"\:") > 0) || (index($return[$i],"\"State\"\:") > 0) || (index($return[$i],"\"AvailabilityZone\"\:") > 0) || (index($return[$i],"\"SubnetId\"\:") > 0) || (index($return[$i],"\"CidrBlock\"\:") > 0) || (index($return[$i],"\"AvailableIpAddressCount\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $subnet1{$record[0]} = $record[1];

        }
  }


#------------------------------------


#------------------------------------
print "\n";
print "Create subnet2 \n";

$CreateSubnet2Cmd = "aws ec2 create-subnet --vpc-id $vpc{VpcId} --cidr-block $subnet2CIDR --output json --region $region";
print "$CreateSubnet2Cmd \n";

#-----
@return = `$CreateSubnet2Cmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"VpcId\"\:") > 0) || (index($return[$i],"\"State\"\:") > 0) || (index($return[$i],"\"AvailabilityZone\"\:") > 0) || (index($return[$i],"\"SubnetId\"\:") > 0) || (index($return[$i],"\"CidrBlock\"\:") > 0) || (index($return[$i],"\"AvailableIpAddressCount\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $subnet2{$record[0]} = $record[1];

        }
  }


#------------------------------------


#------------------------------------

print "\n";
print "Create igw \n";

$CreateGateway = "aws ec2 create-internet-gateway --output json --region $region 2>&1";

print "$CreateGateway \n";

#-----
@return = `$CreateGateway`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"InternetGatewayId\"\:") > 0) || (index($return[$i],"\"Tags\"\:") > 0) || (index($return[$i],"\"Attachments\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $IGW{$record[0]} = $record[1];

        }
  }


#------------------------------------


#------------------------------------
print "\n";
print "Attach igw \n";

$AttachGateway = "aws ec2 attach-internet-gateway --vpc-id $vpc{VpcId} --internet-gateway-id $IGW{InternetGatewayId} --output json --region $region 2>&1";

print "$AttachGateway \n";

#-----
@return = `$AttachGateway`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"InternetGatewayId\"\:") > 0) || (index($return[$i],"\"Tags\"\:") > 0) || (index($return[$i],"\"Attachments\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $attIGW{$record[0]} = $record[1];

        }
  }


#------------------------------------


#------------------------------------
print "\n";
print "Create Route Table\n";

$CreateRouteTable = "aws ec2 create-route-table --vpc-id $vpc{VpcId} --output json --region $region 2>&1";

print "$CreateRouteTable \n";

#-----
@return = `$CreateRouteTable`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"CreateRouteTable\"\:") > 0) || (index($return[$i],"\"Tags\"\:") > 0) || (index($return[$i],"\"Associations\"\:") > 0) || (index($return[$i],"\"RouteTableId\"\:") > 0) || (index($return[$i],"\"VpcId\"\:") > 0) || (index($return[$i],"\"PropagatingVgws\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $routeTable{$record[0]} = $record[1];

        }
  }


#------------------------------------


#------------------------------------
print "\n";
print "Create Route to gateway\n";

$CreateRouteIGW = "aws ec2 create-route --route-table-id $routeTable{RouteTableId} --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW{InternetGatewayId} --output json --region $region";

print "$CreateRouteIGW \n";

#-----
@return = `$CreateRouteIGW`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"Return\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $addRoute1{$record[0]} = $record[1];

        }
  }


#------------------------------------

#aws ec2 associate-route-table  --subnet-id subnet-b46032ec --route-table-id rtb-c1c8faa6
#------------------------------------
print "\n";
print "Associate the routing table with a subnet to allow internet access\n";


$assocRouteTable = "aws ec2 associate-route-table  --subnet-id $subnet1{SubnetId} --route-table-id $routeTable{RouteTableId} --output json --region $region";

print "$assocRouteTable \n";

#-----
@return = `$assocRouteTable`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"Return\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $routeSubnetIGW1{$record[0]} = $record[1];

        }
  }


#------------------------------------

# aws ec2 modify-subnet-attribute --subnet-id $subnet1{SubnetId} --map-public-ip-on-launch
#------------------------------------
print "\n";
print "set the default to always give a public IP to instances launched into the public subnet\n";


$PubIPon = "aws ec2 modify-subnet-attribute --subnet-id $subnet1{SubnetId} --map-public-ip-on-launch --output json --region $region";

print "$PubIPon \n";

#-----
@return = `$PubIPon`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"Return\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $SubnetPubIPon{$record[0]} = $record[1];

        }
  }



##################################
##### 
##### Add SecurityGroups
#####

#-----
#-----







#------------------------------------
# aws ec2 create-security-group --group-name MySecurityGroup --description \"My security group\" --vpc-id $vpc{VpcId}
#------------------------------------
print "\n";
print "Create a security group with ssh and http open for incoming\n";


$SG1cmd = "aws ec2 create-security-group --group-name AutoSG1 --description \"My security group\" --vpc-id $vpc{VpcId}";

print "$SG1cmd \n";

#-----
@return = `$SG1cmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"GroupId\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $SG1{$record[0]} = $record[1];

        }
  }
print "SG1 = $SG1{GroupId} \n";



#------------------------------------
# aws ec2 authorize-security-group-ingress --group-id $SG1{GroupId} --protocol tcp --port 22 --cidr 71.202.150.0/24
#------------------------------------
print "\n";
print "Creatng a rule for the bastion security group to allow incoming ssh\n";


$SG1Rule1cmd = "aws ec2 authorize-security-group-ingress --group-id $SG1{GroupId} --protocol tcp --port 22 --cidr 0.0.0.0/0";

print "$SG1Rule1cmd \n";

#-----
@return = `$SG1Rule1cmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"GroupId\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $SG1{$record[0]} = $record[1];

        }
  }
print "SG1Rule1 = $SG1Rule1{GroupId} \n";



#------------------------------------
# aws ec2 authorize-security-group-ingress --group-id $SG1{GroupId} --protocol icmp --port 22 --cidr 0.0.0.0/0
#------------------------------------
print "\n";
print "Creatng a rule for the bastion security group to allow incoming ping\n";


$SG1Rule2cmd = "aws ec2 authorize-security-group-ingress --group-id $SG1{GroupId} --protocol icmp --port -1 --cidr 0.0.0.0/0";

print "$SG1Rule2cmd \n";

#-----
@return = `$SG1Rule2cmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if (index($return[$i],"\"GroupId\"\:") > 0)
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $SG1{$record[0]} = $record[1];

        }
  }
print "SG1Rule2 = $SG1Rule2{GroupId} \n";



#------------------------------------
# aws ec2 create-key-pair --key-name $Bastion{key} --query 'KeyMaterial' --output text > MyKeyPair.pem
#------------------------------------
print "\n";

print "Creating $Bastion{keyname} key-pair  running \n";


$GenerateKeycmd = "aws ec2 create-key-pair --key-name $Bastion{keyname} --query 'KeyMaterial' --output text > $Bastion{keyname}.pem ; chmod 400 $Bastion{keyname}.pem ";

print "$GenerateKeycmd \n";

#-----
@return = `$GenerateKeycmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
  }


#------------------------------------

# aws ec2 run-instances --image-id ami-02eada62 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-group-ids $SG1{GroupId} --subnet-id $subnet1{SubnetId}
#------------------------------------
print "\n";
print "Create a running instance \n";


#####$CreateInstancecmd = "aws ec2 run-instances --image-id ami-02eada62 --count 1 --instance-type t2.micro --key-name AWS_Auto --security-group-ids $SG1{GroupId} --subnet-id $subnet1{SubnetId}";
$CreateInstancecmd = "aws ec2 run-instances --image-id ami-02eada62 --count 1 --instance-type t2.micro --key-name $Bastion{keyname} --security-group-ids $SG1{GroupId} --subnet-id $subnet1{SubnetId}";

print "$CreateInstancecmd \n";

#-----
@return = `$CreateInstancecmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"ReservationId\"\:") > 0) || (index($return[$i],"\"InstanceId\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $Instance1{$record[0]} = $record[1];

        }
  }
print "InstanceId  = $Instance1{InstanceId}\n";
print "ReservationId  = $Instance1{ReservationId}\n";

################################
## Sleep while instance comes live.
print "######## sleeping for x minutes \n";
sleep 240;
################################

#------------------------------------
# aws ec2 allocate-address --domain vpc --region $region
#------------------------------------
print "\n";
print "Allocate an Elastic IP \n";


$AllocateAddresscmd = "aws ec2 allocate-address --domain vpc --region $region";

print "$AllocateAddresscmd \n";

#-----
@return = `$AllocateAddresscmd`;


for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"PublicIp\"\:") > 0) || (index($return[$i],"\"AllocationId\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $EIPbastion{$record[0]} = $record[1];

        }
  }

print "EIP = $EIPbastion{PublicIp} \n";
print "EIP alloc id = $EIPbastion{AllocationId} \n";

#------------------------------------


#------------------------------------
# aws ec2 associate-address --instance-id $Instance1{InstanceId} --public-ip $EIPbastion{PublicIp} --region $region
#------------------------------------
print "\n";
print "Connect Elastic IP \n";


$AssociateAddresscmd = "aws ec2 associate-address --instance-id $Instance1{InstanceId} --public-ip $EIPbastion{PublicIp} --region $region";

print "$AssociateAddresscmd \n";

#-----
@return = `$AssociateAddresscmd`;


for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"PublicIp\"\:") > 0) || (index($return[$i],"\"AllocationId\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          #$EIPbastion{$record[0]} = $record[1];

        }
  }

#print "EIP = $EIPbastion{PublicIp} \n";

#------------------------------------




#------------------------------------
print "\n\n\n";
print "That\'s it.\n..\n";
print "\n\n\n";

exit;
 
# aws ec2 allocate-address --domain vpc --region $region
# aws ec2 associate-address --instance-id i-07ffe74c7330ebf53 --public-ip 198.51.100.0
