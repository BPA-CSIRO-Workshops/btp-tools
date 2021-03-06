class Picard < FPM::Cookery::Recipe
  description 'A set of tools (in Java) for working with next generation sequencing data in the BAM (http://samtools.sourceforge.net) format.'
  name 'picard'
  version '1.138' 
  revision 0
  homepage 'http://broadinstitute.github.io/picard/'
  source "https://github.com/broadinstitute/picard/releases/download/#{version}/picard-tools-#{version}.zip"
  md5 '0f71cb71c90393e501b8ebc9f867dc0b'

  # Build Dependencies:
  build_depends ['curl', 'default-jre', 'default-jdk', 'ant']

  # Runtime Dependencies:
  depends ['default-jre', 'default-jdk']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["picard-tools-#{version}/*"]
  end
end
