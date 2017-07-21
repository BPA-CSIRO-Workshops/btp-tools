class VCFtools < FPM::Cookery::Recipe
  description 'The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.'
  name 'vcftools'
  version '0.1.13' 
  revision 0
  homepage 'https://vcftools.github.io/'
  source "https://sourceforge.net/projects/vcftools/files/vcftools_#{version}.tar.gz"
  md5 '2414d9adbc86ee5a70c7172efb0c226a'

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'g++', 'pkg-config', 'wget']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install Dir['bin/*']
    #prefix.install Dir['binaries', 'db', 'doc', 'perl5']
  end
end
