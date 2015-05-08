class Tophat < FPM::Cookery::Recipe
  description 'Tophat is a fast splice junction mapper for RNA-Seq reads.'
  name 'tophat'
  version '1.4.1' 
  revision 0
  homepage 'http://ccb.jhu.edu/software/tophat/index.shtml'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/tophat-#{version}.tar.gz"
  md5 '73f7c3b6b2f68f291757026c38eab551'
  
  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
