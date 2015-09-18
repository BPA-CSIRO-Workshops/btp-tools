class Tophat2 < FPM::Cookery::Recipe
  description 'Tophat is a fast splice junction mapper for RNA-Seq reads.'
  name 'tophat2'
  version '2.0.13' 
  revision 0
  homepage 'http://ccb.jhu.edu/software/tophat/index.shtml'
  source "https://ccb.jhu.edu/software/tophat/downloads/tophat-#{version}.Linux_x86_64.tar.gz"
  md5 'af0e1a34b667df56f78597138f45e661'

  build_depends ['curl']
  
  def build
  end

  def install
    bin.install ['tophat', 'tophat2']
  end
end
