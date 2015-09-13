#!/bin/bash

install_dir='/usr/local/tools'
tool_location='https://cran.r-project.org/src/base/R-3/R-3.2.2.tar.gz'
tool_name='r'
md5='57cef5c2e210a5454da1979562a10e5b'

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
dependencies=(wget curl gcc g++ gfortran bison debhelper dh-apparmor gir1.2-freedesktop gir1.2-pango-1.0 html2text libbison-dev libbz2-dev libcairo-script-interpreter2 libcairo2-dev libglib2.0-bin libglib2.0-data libglib2.0-dev libjpeg-dev libjpeg-turbo8-dev libjpeg8-dev liblzma-dev libpango1.0-dev libpcre3-dev libpcrecpp0 libreadline-dev libxcb-render0-dev libxcb-shm0-dev tcl8.5 tcl8.5-dev texi2html tk8.5 tk8.5-dev libx11-dev x11-xkb-utils libxt-dev xdg-utils xfonts-base xserver-common xvfb default-jre default-jdk libxml2-dev libcurl4-openssl-dev)

release=`cat /etc/lsb-release | grep DISTRIB_RELEASE | awk -F '=' '{ print $2 }'`
if [ $release="14.04" ]; then
  dependencies=(${packages[*]} libtiff5-dev libtiffxx5)
else
  dependencies=(${packages[*]} libtiff4-dev libtiffxx0c2)
fi

apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

#######
## R ##
#######
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f R-3.2.2.tar.gz ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 R-3.2.2.tar.gz
tar xvzf R-3.2.2.tar.gz
cd R-3.2.2
./configure --prefix=$install_dir/$tool_name/default
make
make install

cat > /tmp/additional.R << EOF
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("edgeR")
biocLite("cummeRbund")
install.packages(pkgs="gplots",repos="http://cran.csiro.au/")
EOF

$install_dir/$tool_name/default/bin/R CMD BATCH /tmp/additional.R
####################

#################
## Setup Paths ##
#################
chown -R $owner.$owner $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default/bin ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default/bin:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
