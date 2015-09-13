#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/mummer/files/mummer/3.23/MUMmer3.23.tar.gz'
tool_name='mummer'
md5='f2422b3d2638dba4baedb71b1acdffa2'

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
dependencies=(make csh g++)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

############
## MUMmer ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f MUMmer3.23.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 MUMmer3.23.tar.gz
tar -xzf MUMmer3.23.tar.gz
mv MUMmer3.23 default
cd default
make check
make install

# Cleanup
cd ../
rm MUMmer3.23.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
