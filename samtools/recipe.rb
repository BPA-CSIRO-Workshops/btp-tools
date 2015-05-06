class SAMtools < FPM::Cookery::Recipe
  description 'SAMtools provide various utilities for manipulating alignments in the SAM format.'
  name 'samtools'
  version '0.1.18' 
  revision 0
  homepage 'http://samtools.sourceforge.net/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/samtools-#{version}.tar.bz2"
  md5 '71dab132e21c0766f0de84c2371a9157'

  def build
    make
  end

  def install
    bin.install 'samtools'
    lib.install 'libbam.a'
    include('bam').mkdir
    include('bam').install Dir["*.h"]
  end
end
