#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://www.bioinformatics.org/ftp/pub/peakanalyzer/PeakAnalyzer_1.4.tar.gz'
tool_name='peakanalyzer'
md5='d66d414aae2d912786a26f8e35d1b2ae'

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
dependencies=(default-jre default-jdk wget)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

##################
## PeakAnalyzer ##
##################
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f PeakAnalyzer_1.4.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 PeakAnalyzer_1.4.tar.gz
tar -xzf PeakAnalyzer_1.4.tar.gz
mv PeakAnalyzer_1.4 default

# Cleanup
rm PeakAnalyzer_1.4.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
