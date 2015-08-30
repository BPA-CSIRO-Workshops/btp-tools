#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##############
## Bowtie 2 ##
##############
tool_name='bowtie2'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/bowtie2-2.2.4-source.zip
unzip bowtie2-2.2.4-source.zip
# Compile
mv bowtie2-2.2.4 2.2.4
cd 2.2.4/
make
ln -s $install_dir/$tool_name/2.2.4 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm bowtie2-2.2.4-source.zip
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
