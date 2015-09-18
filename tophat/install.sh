#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://ccb.jhu.edu/software/tophat/downloads/tophat-1.4.1.Linux_x86_64.tar.gz'
tool_name='tophat'
md5='f4a3243551c8a5a19b7a1ff115c18447'

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

############
## TopHat ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f tophat-1.4.1.Linux_x86_64.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 tophat-1.4.1.Linux_x86_64.tar.gz
tar -xzf tophat-1.4.1.Linux_x86_64.tar.gz
mv tophat-1.4.1.Linux_x86_64 default

# Cleanup
rm tophat-1.4.1.Linux_x86_64.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
