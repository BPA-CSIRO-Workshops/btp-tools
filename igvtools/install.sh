#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://data.broadinstitute.org/igv/projects/downloads/igvtools_2.3.57.zip'
tool_name='igvtools'
md5='68a3230698bd530544ced92414d45c33'

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
dependencies=(default-jre default-jdk unzip)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##############
## IGVTools ##
##############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f igvtools_2.3.57.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

unzip igvtools_2.3.57.zip
mv IGVTools default
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
