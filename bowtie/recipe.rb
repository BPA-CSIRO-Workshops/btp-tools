class Bowtie < FPM::Cookery::Recipe
  description 'Bowtie is an ultrafast and memory-efficient short read aligner.'
  name 'bowtie'
  version '1.1.2' 
  revision 0
  homepage 'http://bowtie-bio.sourceforge.net/index.shtml'
  source "http://sourceforge.net/projects/bowtie-bio/files/bowtie/#{version}/bowtie-#{version}-src.zip"
  md5 'a51d68366303d7cecaa7f1abea8ef913'

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
