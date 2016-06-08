class Bowtie < FPM::Cookery::Recipe
  description 'Bowtie is an ultrafast and memory-efficient short read aligner.'
  name 'bowtie'
  version '1.1.1' 
  revision 0
  homepage 'http://bowtie-bio.sourceforge.net/index.shtml'
  source "https://sourceforge.net/projects/bowtie-bio/files/bowtie/#{version}/bowtie-#{version}-linux-x86_64.zip"
  md5 '037b012e964cab9ba6bf37ca973f5e13'

  # Let's install build dependencies first.
  build_depends ['curl', 'unzip', 'wget']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["bowtie-#{version}/bowtie*"]
  end
end
