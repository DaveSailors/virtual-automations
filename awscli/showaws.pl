#!/usr/bin/perl
####################################
##
## 03/07/2018 - dsailors - initial creation
##
####################################
#-----------------------------
$year=`date +%Y`; chop($year);
$month=`date +%m`;chop($month);
$day=`date +%d`;  chop($day);
$hour=`date +%H`; chop($hour);
$min=`date +%M`;  chop($min);
$sec=`date +%S`;  chop($sec);
$tstamp = "$year.$month.$day.$hour.$min.$sec";
#-----------------------------
$PID=$$;
$host=`hostname`;
chop($host);
print "$tstamp - $0 starting on $host\n";



  print "==== S3 Storage ===\n";
  @S3stor = `aws s3api list-buckets --output text --query 'Buckets[].[Name].[CreationDate]'`;
     for ($s3 = 0; $s3 <= $#S3stor; $s3++)
       {
          chop($S3stor[$reg]);
          print "S3stor = $S3stor[$s3]\n";
       }


  print "==== SnapShots ===\n";
  @SnapShots = `aws ec2 describe-snapshots --output text --owner-ids self --query 'Snapshots[*].{ID:SnapshotId,Time:StartTime}'`;
          for ($snap = 0; $snap <= $#SnapShots; $snap++)
            {
               chop($SnapShots[$snap]);
               print " SnapShot = $SnapShots[$snap]\n"
            }



  print "\n\n ==== Regions ===\n\n";
  @Regions = `aws ec2 describe-regions --output text | cut -f3`;


   print "showing stuff ??\n";

     for ($reg = 0; $reg <= $#Regions; $reg++)
       {
          chop($Regions[$reg]);
          print "Region = $Regions[$reg]\n";


          @VPCs = `aws ec2 describe-vpcs --output text --region $Regions[$reg] --query 'Vpcs[].[VpcId,IsDefault,CidrBlock,State]'`;
          $dispct = $#VPCs + 1;
          print "\t VPCs = $dispct \n";
          for ($vpc = 0; $vpc <= $#VPCs; $vpc++)
            {
               chop($VPCs[$vpc]);
               print "\t\t VPC  = $VPCs[$vpc]\n"
            }

          @Instances = `aws ec2 describe-instances --output text --region $Regions[$reg] --query 'Reservations[].Instances[].[VpcId,InstanceId,State.Name,InstanceType,LaunchTime]'`;
          $dispct = $#Instances + 1;
          print "\t Instances = $dispct \n";
          for ($inst = 0; $inst <= $#Instances; $inst++)
            {
               chop($Instances[$inst]);
               print "\t\t Instance = $Instances[$inst]\n"
            }

          @AMIs = `aws ec2 describe-images --owners self --output text --region $Regions[$reg] --query 'Images[].[Name,ImageId,CreationDate,State,OwnerId,Public]'`;
          $dispct = $#AMIs + 1;
          print "\t AMIs = $dispct \n";
          for ($ami = 0; $ami <= $#AMIs; $ami++)
            {
               chop($AMIs[$ami]);
               print "\t\t AMI = $AMIs[$ami]\n"
            }

          @Subnets = `aws ec2 describe-subnets --region $Regions[$reg] --output text --query 'Subnets[*].[SubnetId,VpcId,State,MapPublicIpOnLaunch,DefaultForAz,CidrBlock]'  `;
          $dispct = $#Subnets + 1;
          print "\t Subnets = $dispct \n";
          for ($sub = 0; $sub <= $#Subnets; $sub++)
            {
               chop($Subnets[$sub]);
               print "\t\t Subnets  = $Subnets[$sub]\n"
            }

          @RouteTables = `aws ec2 describe-route-tables --region $Regions[$reg] --output text --query 'RouteTables[*].[RouteTableId,VpcId]' `;
          $dispct = $#RouteTables + 1;
          print "\t RouteTables = $dispct \n";
          for ($rtbl = 0; $rtbl <= $#RouteTables; $rtbl++)
            {
               chop($RouteTables[$rtbl]);
               print "\t\t RouteTables  = $RouteTables[$rtbl]\n"
            }

          @ElasticIPs = `aws ec2 describe-addresses --region $Regions[$reg] --output text`;
          $dispct = $#ElasticIPs + 1;
          print "\t ElasticIPs = $dispct \n";
          for ($eip = 0; $eip <= $#ElasticIPs; $eip++)
            {
               chop($ElasticIPs[$eip]);
               print "\t\t Elastic IP's  = $ElasticIPs[$eip]\n"
            }

          @KeyPairs = `aws ec2 describe-key-pairs --region $Regions[$reg] --output text`;
          $dispct = $#KeyPairs + 1;
          print "\t KeyPairs = $dispct \n";
          for ($kp = 0; $kp <= $#KeyPairs; $kp++)
            {
               chop($KeyPairs[$kp]);
               print "\t\t Key Pairs = $KeyPairs[$kp]\n"
            }
          
       }

    
