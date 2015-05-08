class Picard < FPM::Cookery::Recipe
  description 'A set of tools (in Java) for working with next generation sequencing data in the BAM (http://samtools.sourceforge.net) format.'
  name 'picard'
  version '1.119' 
  revision 0
  homepage 'http://broadinstitute.github.io/picard/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/picard-tools-#{version}.zip"
  md5 '84aee7dcce1dc61724e8bba3eb3cd8cc'

  def build
  end

  def install
    bin.install Dir["picard-tools-#{version}/*"]
  end
end
