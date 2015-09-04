#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://github.com/relipmoc/skewer.git'
tool_name='skewer'

##################
## Dependencies ##
##################
dependencies=(git make g++)
apt-get install -y ${dependencies[@]}

############
## Skewer ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

git clone $tool_location default
cd default
sed -i 's/LDFLAGS=-pthread -lrt/LDFLAGS=-pthread/g' Makefile
sed -i 's/$(CXX) $(LDFLAGS) $(OBJECTS) -o $@/$(CXX) $(LDFLAGS) $(OBJECTS) -o $@ -lrt/g' Makefile

# Compile
make
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if [ ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ]; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
