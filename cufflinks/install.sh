#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz'
tool_name='cufflinks'
md5='7e693d182dcfda8aeef8523219ea9ea7'

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
dependencies=(wget)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

###############
## Cufflinks ##
###############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f cufflinks-2.2.1.Linux_x86_64.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 cufflinks-2.2.1.Linux_x86_64.tar.gz
tar -xzf cufflinks-2.2.1.Linux_x86_64.tar.gz

# Install
mkdir default
mv cufflinks-2.2.1.Linux_x86_64 default/bin

# Cleanup
rm cufflinks-2.2.1.Linux_x86_64.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
