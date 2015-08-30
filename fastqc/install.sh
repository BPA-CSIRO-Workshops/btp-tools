#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

############
## FastQC ##
############
tool_name='fastqc'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/fastqc_v0.11.2.zip
unzip fastqc_v0.11.2.zip
mv FastQC 0.11.2
chmod a+x $install_dir/$tool_name/0.11.2/fastqc
ln -s $install_dir/$tool_name/0.11.2 $install_dir/$tool_name/$tool_name-default
# Cleanup
rm fastqc_v0.11.2.zip
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
