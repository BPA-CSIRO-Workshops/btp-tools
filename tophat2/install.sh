#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz'
tool_name='tophat2'
md5='af0e1a34b667df56f78597138f45e661'

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

##############
## TopHat 2 ##
##############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f tophat-2.0.13.Linux_x86_64.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 tophat-2.0.13.Linux_x86_64.tar.gz
tar -xzf tophat-2.0.13.Linux_x86_64.tar.gz
mkdir default
mv tophat-2.0.13.Linux_x86_64/tophat2 default/
mv tophat-2.0.13.Linux_x86_64/tophat default/

# Cleanup
rm -r tophat-2.0.13.Linux_x86_64
rm tophat-2.0.13.Linux_x86_64.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
