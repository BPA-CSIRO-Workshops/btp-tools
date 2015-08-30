#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##############
## SAMtools ##
##############
tool_name='samtools'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the source code
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/samtools-0.1.18.tar.bz2
tar -xjf samtools-0.1.18.tar.bz2
# Compile
mv samtools-0.1.18 0.1.18
cd 0.1.18/
make
mkdir -p $install_dir/$tool_name/0.1.18/lib
cp $install_dir/$tool_name/0.1.18/libbam.a $install_dir/$tool_name/0.1.18/lib/
mkdir -p $install_dir/$tool_name/0.1.18/include/bam
cp $install_dir/$tool_name/0.1.18/*.h $install_dir/$tool_name/0.1.18/include/bam/
ln -s $install_dir/$tool_name/0.1.18 $install_dir/$tool_name/$tool_name-default
# Cleanup
cd ../
rm samtools-0.1.18.tar.bz2
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bcftools ; then" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bcftools:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/misc ; then" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/misc:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/$tool_name-default/bin ; then" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/$tool_name-default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
