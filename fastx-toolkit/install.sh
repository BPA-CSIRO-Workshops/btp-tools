#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2'
tool_name='fastx-toolkit'
md5='bf1993c898626bb147de3d6695c20b40'

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
dependencies=(gcc g++ pkg-config wget curl libgtextutils-dev)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

###################
## FASTX-Toolkit ##
###################
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f fastx_toolkit-0.0.14.tar.bz2 ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 fastx_toolkit-0.0.14.tar.bz2
tar -xjf fastx_toolkit-0.0.14.tar.bz2

# Compile
cd fastx_toolkit-0.0.14
./configure --prefix=$install_dir/$tool_name/default
make; make install

# Cleanup
cd ../
rm -r fastx_toolkit-0.0.14
rm fastx_toolkit-0.0.14.tar.bz2
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
