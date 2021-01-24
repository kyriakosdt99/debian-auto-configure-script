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

#Install basic packages
apt -y install vim git wget curl firefox-esr feh compton xorg build-essential libxft-dev libxinerama-dev libx11-dev fonts-font-awesome unzip nmap dkms

#Make home directory
cd /home/$_USR
if [[ `ls | grep Downloads` == "" ]]; then mkdir Downloads; fi;
if [[ `ls | grep suckless` == "" ]]; then mkdir suckless; fi;
if [[ `ls | grep Pictures` == "" ]]; then mkdir Pictures; fi;

#Install font-awesome
cd Downloads
wget https://use.fontawesome.com/releases/v5.15.2/fontawesome-free-5.15.2-desktop.zip
unzip *.zip
cd `ls | grep fontawesome | grep -v ".zip"`
cd otfs
cp ./* /usr/share/fonts
fc-cache
cd /home/$_USR/Downloads && rm -rf *fontawesome*

#Check if user is in sudoers file:
if [[ `cat /etc/sudoers | grep $_USR` == "" ]]; then
  echo -e "\n\n\tEditing /etc/sudoers file.\nPress any button to continue...\n\n\n";
  read _;
  vim /etc/sudoers;
else
  echo -e "\n\n\tUser already in sudoers file.\nContinuing...\n\n\n";
fi;



