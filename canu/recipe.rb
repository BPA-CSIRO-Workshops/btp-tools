class Canu < FPM::Cookery::Recipe
  description 'Canu specializes in assembling PacBio or Oxford Nanopore sequences.'
  name 'canu'
  version '1.5' 
  revision 0
  homepage 'http://canu.readthedocs.io/en/latest/'
  source "https://github.com/marbl/canu/releases/download/v#{version}/canu-#{version}.Linux-amd64.tar.xz"
  md5 'd02585510cc241b44baa5c2baa8729ab'

  # Let's install build dependencies first.
  build_depends ['curl']

  # Build:  
  def build
  end

  # Install:
  def install
    bin.install Dir['Linux-amd64/bin/*']
  end
end
