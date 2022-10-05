#!/bin/bash

#This is the system information of this device.


#This command shows the hostname of the device.
hostname=$(hostname)


# This command shows domain name.
domainname=$(domainname)


#This command shows the operating system name and version.
OPversion=$(lsb_release -d -s)


#This command shows ip address of the device.
#We used grep command to select the line containing ip address and awk command to select the word from the line by passing it through the pipeline.
ipaddress=$(ip a s ens33 | grep -w inet | awk '{print $2}')


#This command shows the amount of free space available in root filesystem.
#We used df command to display the disc usage, tail to select the last line, and awk to get only the required data.
filesystemfreespace=$(df -h /dev/sda3 | tail -1 | awk '{print $4}')


#to see all the results we are calling all veriable.
cat <<EOF
 Report for $hostname
 
 #########################################################
 FQDN: $domainname
 Operating System name and version: $OPversion 
 IP Address: $ipaddress
 Root Filesystem Free Space: $filesystemfreespace
 ##########################################################
 
EOF
