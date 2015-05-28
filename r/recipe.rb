class RBase < FPM::Cookery::Recipe
  description 'R is a free software environment for statistical computing and graphics.'
  name 'rbase'
  version '3.2.0' 
  revision 0
  homepage 'http://www.r-project.org/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/R-#{version}.tar.gz"
  md5 '66fa17ad457d7e618191aa0f52fc402e'

  build_depends 'bison', 'debhelper', 'dh-apparmor', 'gir1.2-freedesktop', 'gir1.2-pango-1.0', 'html2text', 'libbison-dev', 'libbz2-dev', 'libcairo-script-interpreter2', 'libcairo2-dev', 'libglib2.0-bin', 'libglib2.0-data', 'libglib2.0-dev', 'libjpeg-dev', 'libjpeg-turbo8-dev', 'libjpeg8-dev', 'liblzma-dev', 'libpango1.0-dev', 'libpcre3-dev', 'libpcrecpp0', 'libreadline-dev', 'libtiff4-dev', 'libtiffxx0c2', 'libxcb-render0-dev', 'libxcb-shm0-dev', 'tcl8.5', 'tcl8.5-dev', 'texi2html', 'tk8.5', 'tk8.5-dev', 'x11-xkb-utils', 'xdg-utils', 'xfonts-base', 'xserver-common', 'xvfb'

  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
