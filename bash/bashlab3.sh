#!/bin/bash

#Installing lxd if it is not installed.
which lxd > /dev/null
if [ $? -ne 0 ]; then

	echo "Installing lxd- You may have to insert password"
	sudo snap install lxd
	if [ $? -ne 0 ]; then
	
		echo "lxd installation failed. Ending script execution"
		exit 1
	fi
fi

#Creating lxdbr0 interface if it is not found.
ls /sys/class/net | grep -w "lxdbr0" > /dev/null

if [ $? -ne 0 ]; then
	echo "Initializing lxd"
	lxd init --auto > /dev/null
	if [ $? -ne 0 ]; then
	
		echo "lxd initialization failed. Ending script execution"
		exit 1
	fi
fi

#Launching a container running Ubuntu server named COMP2101-S22 if it is not found.
lxc list | grep -w "COMP2101-S22" > /dev/null

if [ $? -ne 0 ]; then
	echo "Creating container COMP2101-S22 as Ubuntu 20.04 server"
	lxc launch ubuntu:20.04 COMP2101-S22
	if [ $? -ne 0 ]; then
	
		echo "Container creation unsuccessful. Ending script execution"
		exit 1
	fi	
	while [ $(lxc list | grep -w "COMP2101-S22" | awk '{print $6}') = "|" ]; do
		sleep 10
	done
fi
#Adding the name COMP2101-S22 with the container’s IP address in /etc/hosts if it is not there.

grep -w "COMP2101-S22" /etc/hosts > /dev/null

if [ $? -ne 0 ]; then
	##VARIABLES##
	ip=$(lxc list | grep -w "COMP2101-S22" | awk '{print $6}')
	hostname="COMP2101-S22"
	#############
	echo "Adding COMP2101-S22 container to /etc/hosts"
	sudo sed -i.bkp " 2a $ip\t$hostname " /etc/hosts
	if [ $? -ne 0 ]; then
	# if it fails then it shows message and exits
		echo "Appending failed. Ending script execution"
		exit 1
	fi
fi

#Installing Apache2 in container if it is not installed.
lxc exec COMP2101-S22 -- which apache2 > /dev/null

if [ $? -ne 0 ]; then
	echo "Installing apache on container COMP2101-S22"
	lxc exec COMP2101-S22 -- apt install apache2 -y > /dev/null
	if [ $? -ne 0 ]; then
	
		echo "Apache installation failed. Ending script execution"
		exit 1
	fi
fi

#Installing curl if it is not there.
which curl > /dev/null
# if not then it installs it
if [ $? -ne 0 ]; then
	sudo apt install curl -y > /dev/null
	if [ $? -ne 0 ]; then
	
		echo "Curl installation failed. Ending script execution"
		exit 1
	fi
fi
#Retrieving information from web service and notyfying the user about success or failure.

echo "Checking default web page retrival from container COMP2101-S22"
curl http://COMP2101-S22 > /dev/null

if [ $? -ne 0 ]; then
	echo "Default web page retrieval was unsuccessful"
else
	echo "Default web page retrieval was successful"
fi
exit
