class MUMmer < FPM::Cookery::Recipe
  description 'MUMmer is a system for rapidly aligning entire genomes, whether in complete or draft form.'
  name 'mummer'
  version '3.23' 
  revision 0
  homepage 'http://mummer.sourceforge.net/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/MUMmer#{version}.tar.gz"
  md5 'f2422b3d2638dba4baedb71b1acdffa2'

  def build
    safesystem 'make check'
    safesystem 'make install'
  end

  def install
    bin.install ['mummer', 'nucmer', 'promer', 'run-mummer1', 'run-mummer3']
  end
end
