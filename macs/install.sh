#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##########
## MACS ##
##########
tool_name='macs'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/v1.4.2.tar.gz
tar -xzf v1.4.2.tar.gz
# Compile
cd MACS-1.4.2/
python setup.py install --prefix $install_dir/$tool_name/1.4.2
ln -s $install_dir/$tool_name/1.4.2 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm -r MACS-1.4.2
rm v1.4.2.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PYTHONPATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/lib/python2.7/site-packages ; then" > /etc/profile.d/$tool_name.sh
echo "PYTHONPATH=$install_dir/$tool_name/$tool_name-default/lib/python2.7/site-packages:\${PYTHONPATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "alias macs=$install_dir/$tool_name/$tool_name-default/bin/macs15" >> /etc/profile.d/$tool_name.sh
