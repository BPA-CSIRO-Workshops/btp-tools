#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/subread/files/subread-1.4.6-p4/subread-1.4.6-p4-source.tar.gz'
tool_name='subread'
md5='2ad116fe3e76c9d4f9f0481419681e20'

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
dependencies=(make gcc zlib1g zlib1g-dev wget)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

#############
## Subread ##
#############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -e subread-1.4.6-p4-source.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 subread-1.4.6-p4-source.tar.gz
tar -xzf subread-1.4.6-p4-source.tar.gz
mv subread-1.4.6-p4-source default

# Compile
cd default/src
make -f Makefile.Linux

# Cleanup
cd $install_dir/$tool_name
rm subread-1.4.6-p4-source.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if [ ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ]; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin/utilities:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
