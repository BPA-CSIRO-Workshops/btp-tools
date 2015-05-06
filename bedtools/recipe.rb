class Bedtools < FPM::Cookery::Recipe
  description 'bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks.'
  name 'bedtools'
  version '2.22.1' 
  revision 0
  homepage 'http://bedtools.readthedocs.org/en/latest/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/bedtools-#{version}.tar.gz"
  md5 '101c16371e0fd0bb88d55c206e1436d8'

  def build
    make
  end

  def install
    bin.install Dir["bin/*"]
  end
end
