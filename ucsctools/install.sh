#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://hgdownload.soe.ucsc.edu/admin/exe/userApps.v310.src.tgz'
tool_name='ucsctools'
md5='718d5368cca8aee08961489d987b1be5'

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
dependencies=(wget make zlib1g-dev libssl-dev libpng12-0-dev libmysqlclient-dev gcc g++)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

###############
## UCSCTools ##
###############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f userApps.v310.src.tgz ]; then
  wget -4 --no-check-certificate $tool_location
fi

# Compile
tar -xzf userApps.v310.src.tgz
mv userApps default
cd default
make

# Cleanup
cd ../
rm userApps.v310.src.tgz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
