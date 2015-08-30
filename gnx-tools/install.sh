#!/bin/bash

tools_location='https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools'

###############
## gnx-tools ##
###############
cd /tmp/
# Download DEB package
wget -4 --no-check-certificate $tools_location/gnx-tools_0.1+20120305-1_all.deb
dpkg --install /tmp/gnx-tools_0.1+20120305-1_all.deb
# Cleanup
rm /tmp/gnx-tools_0.1+20120305-1_all.deb
####################
