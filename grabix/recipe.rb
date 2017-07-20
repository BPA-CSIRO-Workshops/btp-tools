class Grabix < FPM::Cookery::Recipe
  description 'grabix - a wee tool for random access into BGZF files.'
  name 'grabix'
  version '0.1.6' 
  revision 0
  homepage 'https://github.com/arq5x/grabix'
  source "https://github.com/arq5x/grabix/archive/#{version}.tar.gz"
  md5 '7db21d1c1b8eb5c0572237b280cc1dab'

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'g++', 'pkg-config', 'wget']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install 'grabix'
  end
end
