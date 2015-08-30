#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##########
## BLAT ##
##########
tool_name='blat'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/blatSrc35.zip
unzip blatSrc35.zip
mkdir -p $install_dir/$tool_name/35/bin
cd blatSrc/
sed -i 's/\s*BINDIR\s*=\s*${HOME}\/bin\/${MACHTYPE}/BINDIR=\/tools\/BLAT\/35\/bin/g' inc/common.mk
export MACHTYPE=x86_64
make
ln -s $install_dir/$tool_name/35 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm blatSrc35.zip
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
