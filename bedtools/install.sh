#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##############
## bedtools ##
##############
tool_name='bedtools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/bedtools-2.22.1.tar.gz
tar -xzf bedtools-2.22.1.tar.gz
# Compile
mv bedtools2 2.22.1
cd 2.22.1
make
ln -s $install_dir/$tool_name/2.22.1 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm bedtools-2.22.1.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
