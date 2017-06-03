class Blast < FPM::Cookery::Recipe
  description 'Basic Local Alignment Search Tool.'
  name 'blast'
  version '2.6.0' 
  revision 0
  homepage 'https://blast.ncbi.nlm.nih.gov/Blast.cgi'
  source "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-#{version}+-x64-linux.tar.gz"
  md5 '681b6ecf8d1d08b63f5f940fb53bd6e8'

  # Let's install build dependencies first.
  build_depends ['curl']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir['bin/*']
  end
end
