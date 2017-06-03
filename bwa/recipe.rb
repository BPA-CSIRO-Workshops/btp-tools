class BWA < FPM::Cookery::Recipe
  description 'BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome.'
  name 'bwa'
  version '0.7.15' 
  revision 0
  homepage 'http://bio-bwa.sourceforge.net/'
  source "https://sourceforge.net/projects/bio-bwa/files/bwa-#{version}.tar.bz2"
  md5 'fcf470a46a1dbe2f96a1c5b87c530554'

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'g++', 'pkg-config', 'wget']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install 'bwa'
  end
end
