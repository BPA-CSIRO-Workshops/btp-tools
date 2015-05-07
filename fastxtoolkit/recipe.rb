class FASTXToolkit < FPM::Cookery::Recipe
  description 'The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.'
  name 'fastxtoolkit'
  version '0.0.14' 
  revision 0
  homepage 'http://hannonlab.cshl.edu/fastx_toolkit/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/fastx_toolkit-#{version}.tar.bz2"
  md5 'bf1993c898626bb147de3d6695c20b40'

  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
