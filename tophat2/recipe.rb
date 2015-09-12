class Tophat2 < FPM::Cookery::Recipe
  description 'Tophat is a fast splice junction mapper for RNA-Seq reads.'
  name 'tophat2'
  version '2.0.13' 
  revision 0
  homepage 'http://ccb.jhu.edu/software/tophat/index.shtml'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/tophat-#{version}.tar.gz"
  md5 'df5c22c85d7c631ee37f61e91f81ae4d'

  build_depends ['curl']
  
  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
