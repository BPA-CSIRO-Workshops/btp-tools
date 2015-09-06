#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/bowtie-bio/files/bowtie/1.1.1/bowtie-1.1.1-src.zip'
tool_name='bowtie'
md5='ba4f40528e4eb38976a7ed4bf7c12ca6'

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
dependencies=(g++ unzip wget)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

############
## Bowtie ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f bowtie-1.1.1-src.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 bowtie-1.1.1-src.zip
unzip bowtie-1.1.1-src.zip

# Compile
mv bowtie-1.1.1 default
cd default
make

# Cleanup
cd ../
rm bowtie-1.1.1-src.zip
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
