#!/usr/bin/bash

#Change this to whatever user you want
export _USR=nu11

#Check for root privilages:
if ! [[ `whoami` == "root" ]]; then
  echo -e "\n\n\tNot running as root.\nExiting...\n\n\n";
  exit;
fi;

#Update and upgrade system
apt update && apt upgrade

#Check if user is in sudoers file:

if [[ `cat /etc/sudoers | grep $_USR` == "" ]]; then
  echo -e "\n\n\tEditing /etc/sudoers file.\nPress any button to continue...\n\n\n";
  read _;
  vim /etc/sudoers;
else
  echo -e "\n\n\tUser already in sudoers file.\nContinuing...\n\n\n";
fi;

