class Samtools < FPM::Cookery::Recipe
  description 'SAMtools provide various utilities for manipulating alignments in the SAM format.'
  name 'samtools'
  version '1.4.1' 
  revision 0
  homepage 'http://samtools.sourceforge.net/'
  source "https://github.com/samtools/samtools/releases/download/#{version}/samtools-#{version}.tar.bz2"
  md5 '4860d6a8f85c6965a7e82fb11afbde13'

  # Let's install build dependencies first:
  build_depends ['curl', 'zlib1g-dev', 'ncurses-dev']

  # Build:
  def build
    make
  end

  # Install:
  def install
    make :install, 'DESTDIR' => destdir
  end
end
