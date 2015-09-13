#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/broadinstitute/picard/releases/download/1.138/picard-tools-1.138.zip'
tool_name='picard'
md5='0f71cb71c90393e501b8ebc9f867dc0b'

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
dependencies=(default-jre default-jdk ant unzip)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

############
## Picard ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f picard-tools-1.138.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 picard-tools-1.138.zip
unzip picard-tools-1.138.zip
mv picard-tools-1.138 default

# Cleanup
rm picard-tools-1.138.zip
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
