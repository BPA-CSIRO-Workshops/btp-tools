class FASTXToolkit < FPM::Cookery::Recipe
  description 'The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.'
  name 'fastxtoolkit'
  version '0.0.14' 
  revision 0
  homepage 'http://hannonlab.cshl.edu/fastx_toolkit/'
  source "https://github.com/agordon/fastx_toolkit/releases/download/#{version}/fastx_toolkit-#{version}.tar.bz2"
  md5 'bf1993c898626bb147de3d6695c20b40'

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'g++', 'pkg-config', 'wget', 'libgtextutils-dev']

  def build
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
