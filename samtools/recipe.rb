class SAMtools < FPM::Cookery::Recipe
  description 'SAMtools provide various utilities for manipulating alignments in the SAM format.'
  name 'samtools'
  version '0.1.18' 
  revision 0
  homepage 'http://samtools.sourceforge.net/'
  source "http://sourceforge.net/projects/samtools/files/samtools/#{version}/samtools-#{version}.tar.bz2"
  md5 '71dab132e21c0766f0de84c2371a9157'

  # Let's install build dependencies first.
  build_depends ['curl', 'zlib1g-dev', 'ncurses-dev']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install 'samtools'
    lib.install 'libbam.a'
    include('bam').mkdir
    include('bam').install Dir["*.h"]
  end
end
