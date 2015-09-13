#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/downloads/taoliu/MACS/MACS-1.4.2-1.tar.gz'
tool_name='macs'
md5='950dab09fe1335c8bbb34a896c21e3e2'

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
dependencies=(python wget)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##########
## MACS ##
##########
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f MACS-1.4.2-1.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 MACS-1.4.2-1.tar.gz
tar -xzf MACS-1.4.2-1.tar.gz

# Compile
cd MACS-1.4.2/
python setup.py install --prefix $install_dir/$tool_name/default

# Cleanup
cd ../
rm -r MACS-1.4.2
rm MACS-1.4.2-1.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PYTHONPATH} | /bin/grep -q $install_dir/$tool_name/default/lib/python2.7/site-packages ; then" > /etc/profile.d/$tool_name.sh
echo "PYTHONPATH=$install_dir/$tool_name/default/lib/python2.7/site-packages:\${PYTHONPATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "alias macs=$install_dir/$tool_name/default/bin/macs14" >> /etc/profile.d/$tool_name.sh
