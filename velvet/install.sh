#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://www.ebi.ac.uk/~zerbino/velvet/velvet_1.2.10.tgz'
tool_name='velvet'
md5='6e28c4b9bedc5f7ab2b947e7266a02f6'

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
dependencies=(wget zlib1g-dev)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

############
## Velvet ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f velvet_1.2.10.tgz ]; then
  wget -4 --no-check-certificate $tool_location
fi

# Compile
tar -xzf velvet_1.2.10.tgz
mv velvet_1.2.10 default
cd default
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1'
make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1' color
make doc

# Cleanup
cd ../
rm velvet_1.2.10.tgz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "alias velveth_long=$install_dir/$tool_name/default/velveth" >> /etc/profile.d/$tool_name.sh
echo "alias velvetg_long=$install_dir/$tool_name/default/velvetg" >> /etc/profile.d/$tool_name.sh
