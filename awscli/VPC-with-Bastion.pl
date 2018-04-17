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

#### -----

$Bastion{keyname} = "Bastion-$vpc{VpcId}";
$NAT{keyname} = "NAT-$vpc{VpcId}";

#### -----

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

print "\n";
#------------------------------------

# Create Subnets
#-----

print "Create subnet1 \n";

$CreateSubnet1Cmd = "aws ec2 create-subnet --vpc-id $vpc{VpcId} --cidr-block $subnet1CIDR --output json --region $region";
print "$CreateSubnet1Cmd \n";

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
print "\n";


#------------------------------------

# Create Internet Gateway
#-----

print "Create Internet Gateway (igw) \n";

$CreateGateway = "aws ec2 create-internet-gateway --output json --region $region 2>&1";

print "$CreateGateway \n";

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
print "\n";

#------------------------------------

# Attach IGW to the VPC
#-----

print "Attachng igw \n";

$AttachGateway = "aws ec2 attach-internet-gateway --vpc-id $vpc{VpcId} --internet-gateway-id $IGW{InternetGatewayId} --output json --region $region 2>&1";

print "$AttachGateway \n";

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
print "\n";

#------------------------------------

# Create Route Table for IGW
#-----

print "Create Route Table\n";

$CreateRouteTable = "aws ec2 create-route-table --vpc-id $vpc{VpcId} --output json --region $region 2>&1";

print "$CreateRouteTable \n";

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
print "\n";

#------------------------------------

# Create the route to the IGW
#-----

print "Create Route to gateway\n";

$CreateRouteIGW = "aws ec2 create-route --route-table-id $routeTable{RouteTableId} --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW{InternetGatewayId} --output json --region $region";

print "$CreateRouteIGW \n";

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
print "\n";


#------------------------------------

# Associate the Route Table with the subnet to pickup the route to the IGW
#-----

print "Associate the routing table with a subnet to allow internet access\n";


$assocRouteTable = "aws ec2 associate-route-table  --subnet-id $subnet1{SubnetId} --route-table-id $routeTable{RouteTableId} --output json --region $region";

print "$assocRouteTable \n";

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


print "\n";

#------------------------------------

# Public IP addresses for the public segment ?  ( I may turn this off )
#-----

print "set the default to always give a public IP to instances launched into the public subnet\n";


$PubIPon = "aws ec2 modify-subnet-attribute --subnet-id $subnet1{SubnetId} --map-public-ip-on-launch --output json --region $region";

print "$PubIPon \n";

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

print "\n";

#------------------------------------
#------------------------------------
#------------------------------------
print "######################## %%%%%%%%%\n";
#------------------------------------
#------------------------------------
#------------------------------------

# Create Route Table for private subnet
#-----

print "Create Route Table2\n";

$CreateRouteTable2 = "aws ec2 create-route-table --vpc-id $vpc{VpcId} --output json --region $region 2>&1";

print "$CreateRouteTable2 \n";

@return = `$CreateRouteTable2`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
     if ((index($return[$i],"\"CreateRouteTable2\"\:") > 0) || (index($return[$i],"\"Tags\"\:") > 0) || (index($return[$i],"\"Associations\"\:") > 0) || (index($return[$i],"\"RouteTableId\"\:") > 0) || (index($return[$i],"\"VpcId\"\:") > 0) || (index($return[$i],"\"PropagatingVgws\"\:") > 0))
        {
          $prepedrec = $return[$i];
          while (substr($prepedrec,0,1) eq ' ')
            {
              $prepedrec = substr($prepedrec,1,length($prepedrec));
            }
          $prepedrec =~ s/,//g;
          $prepedrec =~ s/"//g;
          @record = split(/[:]+/,$prepedrec);
          $routeTable2{$record[0]} = $record[1];

        }
  }
print "\n";

#------------------------------------

# Associate the Route Table with private subnet
#-----

print "Associate the routing table with private subnet\n";


$assocRouteTable2 = "aws ec2 associate-route-table  --subnet-id $subnet2{SubnetId} --route-table-id $routeTable2{RouteTableId} --output json --region $region";

print "$assocRouteTable2 \n";

@return = `$assocRouteTable2`;
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
          $routePrvate{$record[0]} = $record[1];

        }
  }


print "\n";

#------------------------------------

# Create SG for inbound into NAT
#-----

print "Create SG to use the NAT \n";


$SG2cmd = "aws ec2 create-security-group --group-name AutoSG2 --description \"SG to allow access to the NAT\" --vpc-id $vpc{VpcId}";

print "$SG2cmd \n";

@return = `$SG2cmd`;

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
          $SG2{$record[0]} = $record[1];

        }
  }
print "SG2 = $SG2{GroupId} \n";

print "\n";

#------------------------------------

# add Rule for incoming to NAT 
#-----

print "Creatng a rule for the bastion security group to allow incoming ssh\n";


$SG2Rule1cmd = "aws ec2 authorize-security-group-ingress --group-id $SG2{GroupId} --protocol all --cidr $subnet2CIDR";

print "$SG2Rule1cmd \n";

@return = `$SG2Rule1cmd`;

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
          $SG2{$record[0]} = $record[1];

        }
  }
print "SG2Rule1 = $SG2Rule1{GroupId} \n";

print "\n";

#------------------------------------

# Create a key pair for access to the NAT Host
#-----

print "Creating $NAT{keyname} key-pair  running \n";


$GenerateKeycmd = "aws ec2 create-key-pair --key-name $NAT{keyname} --query 'KeyMaterial' --output text > $NAT{keyname}.pem ; chmod 400 $NAT{keyname}.pem ";

print "$GenerateKeycmd \n";

@return = `$GenerateKeycmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
  }
print "\n";

#------------------------------------

# Create a running instance for the NAT - Not an AWS managed NAT
#-----

print "Create NAT Host \n";


$CreateNATInstcmd = "aws ec2 run-instances --image-id ami-02eada62 --count 1 --instance-type t2.micro --key-name $NAT{keyname} --security-group-ids $SG1{GroupId} --subnet-id $subnet1{SubnetId}";

print "$CreateNATInstcmd \n";

@return = `$CreateNATInstcmd`;

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
          $NATInst{$record[0]} = $record[1];

        }
  }
print "InstanceId  = $NATInst{InstanceId}\n";
print "ReservationId  = $NATInst{ReservationId}\n";
print "\n";

################################
## Sleep while instance comes live.
$sleeptime = 90;

print "######## sleeping for $sleeptime seconds \n";
sleep $sleeptime;

################################

#------------------------------------




##################################
##### 
##### SecurityGroups
#####
##################################



# Create SG with incoming ssh and http 
#-----

print "Create a security group \n";


$SG1cmd = "aws ec2 create-security-group --group-name AutoSG1 --description \"My security group\" --vpc-id $vpc{VpcId}";

print "$SG1cmd \n";

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

print "\n";

#------------------------------------

# add Rule for incoming ssh 
#-----

print "Creatng a rule for the bastion security group to allow incoming ssh\n";


$SG1Rule1cmd = "aws ec2 authorize-security-group-ingress --group-id $SG1{GroupId} --protocol tcp --port 22 --cidr 0.0.0.0/0";

print "$SG1Rule1cmd \n";

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

print "\n";

#------------------------------------

# add incoming ping to the security group 
#-----

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
print "\n";

#------------------------------------

# Create a key pair for access to the Bastion Host
#-----

print "Creating $Bastion{keyname} key-pair  running \n";


$GenerateKeycmd = "aws ec2 create-key-pair --key-name $Bastion{keyname} --query 'KeyMaterial' --output text > $Bastion{keyname}.pem ; chmod 400 $Bastion{keyname}.pem ";

print "$GenerateKeycmd \n";

@return = `$GenerateKeycmd`;

for ($i = 0; $i <= $#return; $i++)
  {
     chomp($return[$i]);
     print "$return[$i]\n";
  }
print "\n";

#------------------------------------

# Create a running instance ( Bastion )
#-----

print "Create Bastion Host \n";


$CreateInstancecmd = "aws ec2 run-instances --image-id ami-02eada62 --count 1 --instance-type t2.micro --key-name $Bastion{keyname} --security-group-ids $SG1{GroupId} --subnet-id $subnet1{SubnetId}";

print "$CreateInstancecmd \n";

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
print "\n";

################################
## Sleep while instance comes live.
$sleeptime = 90;

print "######## sleeping for $sleeptime seconds \n";
sleep $sleeptime;

################################

#------------------------------------

# Allocate an Elastic IP
#-----

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

print "\n";

#------------------------------------

# Associate the EIP with the Bastion instance
#-----

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
$EIPbastion{PublicIp} =~ s/ //g;
$connectString = "ssh -i \"$Bastion{keyname}.pem\" ec2-user\@$EIPbastion{PublicIp}";
print "To connect from linux : \n $connectString \n";



print "\n\n\n";

exit;
 
