#!/bin/bash

#######
## R ##
#######
cd /tmp/
ubuntu_version=`lsb_release -s -c`
cat > /etc/apt/sources.list.d/r.list << EOF
deb http://cran.csiro.au/bin/linux/ubuntu $ubuntu_version/
EOF
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update
apt-get install -y r-base
# Additional R Libraries
cat > /tmp/additional.R << EOF
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("edgeR")
biocLite("cummeRbund")
install.packages(pkgs="gplots",repos="http://cran.csiro.au/")
EOF
/usr/bin/R CMD BATCH /tmp/additional.R
####################
