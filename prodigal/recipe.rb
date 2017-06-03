class Prodigal < FPM::Cookery::Recipe
  description 'Prokaryotic Dynamic Programming Genefinding Algorithm.'
  name 'prodigal'
  version '2.6.3' 
  revision 0
  homepage 'http://prodigal.ornl.gov/'
  source "https://github.com/hyattpd/Prodigal/archive/v#{version}.tar.gz"
  md5 '5181809fdb740e9a675cfdbb6c038466'

  # Let's install build dependencies first.
  build_depends ['curl', 'gcc', 'g++', 'pkg-config', 'wget']

  # Build:
  def build
    make
  end

  # Install:
  def install
    bin.install 'prodigal'
  end
end
