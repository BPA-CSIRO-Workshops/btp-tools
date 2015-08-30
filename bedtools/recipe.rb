class Bedtools < FPM::Cookery::Recipe
  description 'bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks.'
  name 'bedtools'
  version '2.22.1' 
  revision 0
  homepage 'http://bedtools.readthedocs.org/en/latest/'
  source "https://github.com/arq5x/bedtools2/archive/v#{version}.tar.gz"
  md5 '101c16371e0fd0bb88d55c206e1436d8'

  def build
    make
  end

  def install
    bin.install Dir["bin/*"]
  end
end
