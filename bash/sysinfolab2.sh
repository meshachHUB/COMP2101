#!/bin/bash

#This is the system information of this device.


#This command shows the hostname of the device.
hostname=$(hostname)


# This command shows domain name.
domainname=$(domainname)


#This command shows the operating system name and version.
OPversion=$(lsb_release -d -s)


#This command shows ip address of the device.
ipaddress=$(ip a s ens33 | grep -w inet | awk '{print $2}')


#This command shows the amount of free space available in root filesystem.
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
