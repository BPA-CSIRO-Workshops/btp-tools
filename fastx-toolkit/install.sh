#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

###################
## FASTX-Toolkit ##
###################
tool_name='fastx-toolkit'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/fastx_toolkit-0.0.14.tar.bz2
tar -xjf fastx_toolkit-0.0.14.tar.bz2
# Compile
cd fastx_toolkit-0.0.14
./configure --prefix=$install_dir/$tool_name/0.0.14
make; make install
ln -s $install_dir/$tool_name/0.0.14 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm -r fastx_toolkit-0.0.14
rm fastx_toolkit-0.0.14.tar.bz2
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
