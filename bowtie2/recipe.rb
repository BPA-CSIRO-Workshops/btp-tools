class Bowtie2 < FPM::Cookery::Recipe
  description 'Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences.'
  name 'bowtie2'
  version '2.2.4'
  revision 0
  homepage 'http://bowtie-bio.sourceforge.net/index.shtml'
  source "http://sourceforge.net/projects/bowtie-bio/files/bowtie2/#{version}/bowtie2-#{version}-source.zip"
  md5 'd31294875092e76ebb061eadc7998582'

  build_depends ['curl', 'g++', 'unzip', 'wget']

  def build
    Dir.chdir "bowtie2-#{version}" do
      make
    end
  end

  def install
    Dir.chdir "bowtie2-#{version}" do
      bin.install ['bowtie2', 'bowtie2-align-s', 'bowtie2-align-l', 'bowtie2-build', 'bowtie2-build-s', 'bowtie2-build-l', 'bowtie2-inspect', 'bowtie2-inspect-s', 'bowtie2-inspect-l']
    end
  end
end
