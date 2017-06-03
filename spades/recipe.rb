class SPAdes < FPM::Cookery::Recipe
  description 'BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome.'
  name 'spades'
  version '3.10.1' 
  revision 0
  homepage 'http://cab.spbu.ru/software/spades/'
  source "http://cab.spbu.ru/files/release#{version}/SPAdes-#{version}-Linux.tar.gz"
  md5 'fb58d48a0545211aab91f43b7d17ad1b'

  # Let's install build dependencies first.
  build_depends ['curl']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir['bin/*']
  end
end
