#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.4/bowtie2-2.2.4-source.zip'
tool_name='bowtie2'
md5='d31294875092e76ebb061eadc7998582'

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

##############
## Bowtie 2 ##
##############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f bowtie2-2.2.4-source.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 bowtie2-2.2.4-source.zip
unzip bowtie2-2.2.4-source.zip
mv bowtie2-2.2.4 default

# Compile
cd default
make

# Cleanup
cd ../
rm bowtie2-2.2.4-source.zip
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
