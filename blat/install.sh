#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/blatSrc35.zip'
tool_name='blat'
md5='16e546b8843b85e0b0f2fa603cd78724'

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
dependencies=(wget unzip libpng12-dev)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##########
## BLAT ##
##########
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f blatSrc35.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 blatSrc35.zip
unzip blatSrc35.zip
mkdir -p $install_dir/$tool_name/35/bin
mv blatSrc default
cd default
mkdir bin
sed -i 's/\s*BINDIR\s*=\s*${HOME}\/bin\/${MACHTYPE}/BINDIR=\/usr\/local\/tools\/blat\/default\/bin/g' inc/common.mk
export MACHTYPE=x86_64
make

# Cleanup
cd ../
rm blatSrc35.zip
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
