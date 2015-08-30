#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

############
## Velvet ##
############
tool_name='velvet'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/velvet_1.2.10.tgz
tar -xzf velvet_1.2.10.tgz
# Compile
mv velvet_1.2.10 1.2.10
cd 1.2.10
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1'
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1' color
make doc
ln -s $install_dir/$tool_name/1.2.10 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm velvet_1.2.10.tgz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "alias velveth_long=$install_dir/$tool_name/$tool_name-default/velveth" >> /etc/profile.d/$tool_name.sh
echo "alias velvetg_long=$install_dir/$tool_name/$tool_name-default/velvetg" >> /etc/profile.d/$tool_name.sh
