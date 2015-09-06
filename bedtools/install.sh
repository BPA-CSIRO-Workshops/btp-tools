#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/arq5x/bedtools2/archive/v2.22.1.tar.gz'
tool_name='bedtools'
md5='488c94858a6e2fb8fec68c3697444b6d'

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
dependencies=(make g++ wget zlib1g-dev)  
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##############
## bedtools ##
##############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f v2.22.1.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 v2.22.1.tar.gz
tar -xzf v2.22.1.tar.gz
mv bedtools2-2.22.1 default

# Compile
cd default
make

# Cleanup
cd ../
rm v2.22.1.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
