class HMMER < FPM::Cookery::Recipe
  description 'biosequence analysis using profile hidden Markov models.'
  name 'hmmer'
  version '3.1b2' 
  revision 0
  homepage 'http://hmmer.org/'
  source "https://sourceforge.net/projects/bowtie-bio/files/bowtie/#{version}/bowtie-#{version}-linux-x86_64.zip"
  source "http://eddylab.org/software/hmmer3/#{version}/hmmer-#{version}-linux-intel-x86_64.tar.gz"
  md5 '44ea3dc8b50657101ab9ba1807ccfcd3'

  # Let's install build dependencies first.
  build_depends ['curl', 'unzip', 'wget']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["binaries/*"]
    share.install Dir["share/*"]
  end
end
