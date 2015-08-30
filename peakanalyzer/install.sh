#!/bin/bash

install_dir='/tools'
owner='ubuntu'
tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

##################
## PeakAnalyzer ##
##################
tool_name='peakanalyzer'
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi
# Download the jar files
cd $install_dir/$tool_name
wget -4 --no-check-certificate $tools_location/PeakAnalyzer_1.4.tar.gz
tar -xzf PeakAnalyzer_1.4.tar.gz
mv PeakAnalyzer_1.4 1.4
ln -s $install_dir/$tool_name/1.4 $install_dir/$tool_name/peakanalyzer-default
# Cleanup
rm PeakAnalyzer_1.4.tar.gz
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
