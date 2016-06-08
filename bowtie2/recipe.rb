class Bowtie2 < FPM::Cookery::Recipe
  description 'Bowtie 2 is an ultrafast and memory-efficient tool for aligning sequencing reads to long reference sequences.'
  name 'bowtie2'
  version '2.2.4'
  revision 0
  homepage 'http://bowtie-bio.sourceforge.net/index.shtml'
  source "https://sourceforge.net/projects/bowtie-bio/files/bowtie2/#{version}/bowtie2-#{version}-linux-x86_64.zip"
  md5 'e54e41c720121da9f234319359347bab'

  # Let's install build dependencies first.
  build_depends ['curl', 'unzip', 'wget']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["bowtie2-#{version}/bowtie*"]
  end
end
