#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##############
## IGVTools ##
##############
tool_name='igvtools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/igvtools_2.3.40.zip
unzip igvtools_2.3.40.zip
ln -s $install_dir/$tool_name/2.3.40 $install_dir/$tool_name/$tool_name-default
mv IGVTools 2.3.40
# Cleanup
rm igvtools_2.3.40.zip
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
