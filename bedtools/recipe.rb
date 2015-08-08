class Bedtools < FPM::Cookery::Recipe
  description 'bedtools utilities are a swiss-army knife of tools for a wide-range of genomics analysis tasks.'
  name 'bedtools'
  version '2.24' 
  revision 0
  homepage 'http://bedtools.readthedocs.org/en/latest/'
  source "https://github.com/arq5x/bedtools2/archive/v#{version}.tar.gz"
  md5 'a93c6c8569d5497b7cc09a433e1739fa'

  def build
    make
  end

  def install
    bin.install Dir["bin/*"]
  end
end
