class Bowtie < FPM::Cookery::Recipe
  description 'Bowtie is an ultrafast and memory-efficient short read aligner.'
  name 'bowtie'
  version '1.1.1' 
  revision 0
  homepage 'http://bowtie-bio.sourceforge.net/index.shtml'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/bowtie-#{version}-src.zip"
  md5 'ba4f40528e4eb38976a7ed4bf7c12ca6'

  def build
    Dir.chdir "bowtie-#{version}" do
      make
    end
  end

  def install
    Dir.chdir "bowtie-#{version}" do
      bin.install ['bowtie', 'bowtie-align-s', 'bowtie-align-l', 'bowtie-build', 'bowtie-build-s', 'bowtie-build-l', 'bowtie-inspect', 'bowtie-inspect-s', 'bowtie-inspect-l']
    end
  end
end
