#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##############
## TopHat 2 ##
##############
tool_name='tophat2'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/tophat-2.0.13.tar.gz
tar -xzf tophat-2.0.13.tar.gz
# Compile
cd tophat-2.0.13
./configure --prefix=$install_dir/$tool_name/2.0.13 --with-bam=$install_dir/samtools/samtools-default
make all
make install
ln -s $install_dir/$tool_name/2.0.13 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm -r tophat-2.0.13
rm tophat-2.0.13.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
