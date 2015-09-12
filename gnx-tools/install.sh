#!/bin/bash

install_dir='/usr/local/tools'
tool_name='gnx-tools'

##################
## Dependencies ##
##################
dependencies=(default-jre default-jdk ant git)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

###############
## gnx-tools ##
###############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

# Checkout
git clone https://github.com/mh11/gnx-tools.git default

# Compile
cd default
mkdir bin
javac -d bin src/uk/ac/ebi/gnx/*
ant -f package.xml
####################

#################
## Setup Paths ##
#################
echo "#!/bin/sh" >> $install_dir/$tool_name/default/gnx
echo "# Simple wrapper to run gnx-tools" >> $install_dir/$tool_name/default/gnx
echo "exec java -jar $install_dir/$tool_name/default/gnx.jar \"\$@\"" >> $install_dir/$tool_name/default/gnx
chmod a+x $install_dir/$tool_name/default/gnx
chown -R root.root $install_dir/$tool_name/
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
