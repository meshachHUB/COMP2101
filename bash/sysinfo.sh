#!/bin/bash

# sysinfo.sh 

hostname=$(hostname)

Operatingsystem=$(hostnamectl)

ipaddress=$(hostname -I )

rootfilesystem=$(df -h | grep /dev/sda3 )

cat <<EOF

Report for $hostname
######################################

Operating System And version :$Operatingsystem
Ip Address :$ipaddress
Root FIlesystem Free Status:$rootfilesystem

######################################
EOF
