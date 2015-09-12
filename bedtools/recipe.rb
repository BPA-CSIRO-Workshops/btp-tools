class Bedtools < FPM::Cookery::Recipe
  description 'bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks.'
  name 'bedtools'
  version '2.22.1' 
  revision 0
  homepage 'http://bedtools.readthedocs.org/en/latest/'
  source "https://github.com/arq5x/bedtools2/archive/v#{version}.tar.gz"
  md5 '488c94858a6e2fb8fec68c3697444b6d'

  build_depends ['curl', 'make', 'g++', 'wget', 'zlib1g-dev']

  def build
    make
  end

  def install
    bin.install Dir["bin/*"]
  end
end
