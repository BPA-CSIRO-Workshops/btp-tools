class RBase < FPM::Cookery::Recipe
  description 'R is a free software environment for statistical computing and graphics.'
  name 'rbase'
  version '3.2.2' 
  revision 0
  homepage 'http://www.r-project.org/'
  source "https://cran.r-project.org/src/base/R-3/R-#{version}.tar.gz"
  md5 '57cef5c2e210a5454da1979562a10e5b'

  build_depends ['curl', 'bison', 'debhelper', 'dh-apparmor', 'gir1.2-freedesktop', 'gir1.2-pango-1.0', 'html2text', 'libbison-dev', 'libbz2-dev', 'libcairo-script-interpreter2', 'libcairo2-dev', 'libglib2.0-bin', 'libglib2.0-data', 'libglib2.0-dev', 'libjpeg-dev', 'libjpeg-turbo8-dev', 'libjpeg8-dev', 'liblzma-dev', 'libpango1.0-dev', 'libpcre3-dev', 'libpcrecpp0', 'libreadline-dev', 'libxcb-render0-dev', 'libxcb-shm0-dev', 'tcl8.5', 'tcl8.5-dev', 'texi2html', 'tk8.5', 'tk8.5-dev', 'libx11-dev', 'x11-xkb-utils', 'libxt-dev', 'xdg-utils', 'xfonts-base', 'xserver-common', 'xvfb', 'default-jre', 'default-jdk', 'libxml2-dev', 'libcurl4-openssl-dev']

  def build
    configure :prefix => prefix
    make
    
    File.open('additional.R', 'w', 0755) do |f|
      f.write <<-__EOF
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("edgeR")
biocLite("cummeRbund")
install.packages(pkgs="gplots",repos="http://cran.csiro.au/")
      __EOF
    end

    File.open('additional.sh', 'w', 0755) do |f|
      f.write <<-__EOF
#!/bin/bash
#{builddir}/R-#{version}/bin/R CMD BATCH additional.R
      __EOF
    end

    safesystem 'bash', './additional.sh'
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
