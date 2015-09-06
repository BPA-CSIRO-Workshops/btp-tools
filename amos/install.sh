#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/amos/files/amos/3.1.0/amos-3.1.0.tar.gz'
tool_name='amos'
md5='51ebe835c93eef9acd39101738b2048c'

function md5check {
  md5sum -c - <<< "$1 $2"
  if [ $? -ne 0 ]; then
    echo "MD5 mismatch on downloaded file, exiting ..."
    exit
  fi
}

##################
## Dependencies ##
##################
dependencies=(make g++ libboost-all-dev libqt4-dev libxml-perl libdbi-perl libstatistics-descriptive-perl)

if [ `lsb_release -sr`='14.04' ]; then
  packages=(${packages[*]} libboost1.54-all-dev)
else
  packages=(${packages[*]} libboost1.48-all-dev)
fi

apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##########
## AMOS ##
##########
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -e amos-3.1.0.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 amos-3.1.0.tar.gz
tar -xzf amos-3.1.0.tar.gz
cd amos-3.1.0/
sed -i "1i#include <getopt.h>" ./src/Align/find-tandem.cc
./configure --prefix=$install_dir/$tool_name/default --enable-minimus=no
make
make install

# Cleanup
cd ../
rm -r amos-3.1.0/
rm amos-3.1.0.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
