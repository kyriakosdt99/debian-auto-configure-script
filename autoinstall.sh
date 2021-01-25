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
apt -y install vim git wget curl firefox-esr feh compton xorg build-essential libxft-dev libxinerama-dev libx11-dev fonts-font-awesome unzip nmap dkms sudo

#Make home directory
cd /home/$_USR
if [[ `ls | grep Downloads` == "" ]]; then mkdir Downloads; fi;
if [[ `ls | grep suckless` == "" ]]; then mkdir suckless; fi;
if [[ `ls | grep Pictures` == "" ]]; then mkdir Pictures; fi;

#Check if font-awesome is installed:
if [[ `fc-list` == *"Font Awesome 5"* ]]; then
  echo -e "\n\n\tFont Awesome already installed.\n\n\n"
else
  echo -e "\n\n\tInstalling Font Awesome\n\n\n"
  cd Downloads
  wget https://use.fontawesome.com/releases/v5.15.2/fontawesome-free-5.15.2-desktop.zip
  unzip *.zip
  cd `ls | grep fontawesome | grep -v ".zip"`
  cd otfs
  cp ./* /usr/share/fonts
  fc-cache
  cd /home/$_USR/Downloads && rm -rf *fontawesome*
fi;

#Check if user is in sudoers file:
if [[ `cat /etc/sudoers | grep $_USR` == "" ]]; then
  echo -e "\n\n\tEditing /etc/sudoers file.\nPress any button to continue...\n\n\n";
  read _;
  vim /etc/sudoers;
else
  echo -e "\n\n\tUser already in sudoers file.\nContinuing...\n\n\n";
fi;

#Cloning .xinitrc
cd /home/$_USR
if [[ `ls -a | grep ".xinitrc"` == "" ]]; then
  echo -e "\n\n\tCloning .xinitrc\n\n\n"
  wget https://raw.githubusercontent.com/kyriakosdt99/dot_files_debian/main/.xinitrc
else
  echo -e "\n\n\t.xinitrc is already installed\n\n\n"
fi;

#Install batt_perc.sh
if [[ `ls /usr/bin | grep batt_perc` == "" ]]; then
  echo -e "\n\n\tCloning batt_perc.sh\n\n\n"
  cd /home/$_USR && wget https://raw.githubusercontent.com/kyriakosdt99/batt_perc/main/batt_perc.sh
  chmod +x batt_perc.sh && mv batt_perc.sh /usr/bin/
else
  echo -e "\n\n\tbatt_perc.sh already in bin\n\n\n"
fi;

#Check if suckless utils are installed:
if ! [[ `ls /home/$_USR/suckless` == "" ]]; then 
  echo -e "\n\n\tSuckless utils are already installed\n\n\n"
else
  echo -e "\n\n\tCloning dwm, st and slstatus..\n\n\n"
  cd /home/$_USR/suckless
  git clone https://git.suckless.org/dwm 
  git clone https://git.suckless.org/st
  git clone https://git.suckless.org/slstatus

  cd dwm
  wget https://raw.githubusercontent.com/kyriakosdt99/suckless_conf_files/main/dwm_config.def.h 
  mv dwm_config.def.h config.def.h
  make clean install 
  
  cd ../st
  wget https://raw.githubusercontent.com/kyriakosdt99/suckless_conf_files/main/st_config.def.h 
  mv st_config.def.h config.def.h
  make clean install
  
  cd ../slstatus
  wget https://raw.githubusercontent.com/kyriakosdt99/suckless_conf_files/main/slstatus_config.def.h 
  mv slstatus_config.def.h config.def.h
  cd components && wget https://raw.githubusercontent.com/kyriakosdt99/suckless_conf_files/main/run_command.c && cd .. &&
  make clean install
fi;
