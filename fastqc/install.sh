#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.3_source.zip'
tool_name='fastqc'
md5='80b3ad1af0a2b2594318857ed7d7c237'

function md5check {
  md5sum -c - <<< "$1 $2"
  if [ $? -ne 0 ]; then
    echo "MD5 mismatch on downloaded file, exiting ..."
    exit
  fi
}

############
## FastQC ##
############
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -e fastqc_v0.11.3_source.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 fastqc_v0.11.3_source.zip
unzip fastqc_v0.11.3_source.zip
mv FastQC default
chmod a+x $install_dir/$tool_name/default/fastqc

# Cleanup
rm fastqc_v0.11.3_source.zip
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
