#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://sourceforge.net/projects/samtools/files/samtools/0.1.18/samtools-0.1.18.tar.bz2'
tool_name='samtools'
md5='71dab132e21c0766f0de84c2371a9157'

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
dependencies=(wget zlib1g-dev ncurses-dev)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##############
## SAMtools ##
##############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f samtools-0.1.18.tar.bz2 ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 samtools-0.1.18.tar.bz2
tar -xjf samtools-0.1.18.tar.bz2
mv samtools-0.1.18 default

# Compile
cd default
make
mkdir -p $install_dir/$tool_name/default/lib
cp $install_dir/$tool_name/default/libbam.a $install_dir/$tool_name/default/lib/
mkdir -p $install_dir/$tool_name/default/include/bam
cp $install_dir/$tool_name/default/*.h $install_dir/$tool_name/default/include/bam/

# Cleanup
cd ../
rm samtools-0.1.18.tar.bz2
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bcftools ; then" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bcftools:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/misc ; then" >> /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/misc:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
