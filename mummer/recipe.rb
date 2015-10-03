class MUMmer < FPM::Cookery::Recipe
  description 'MUMmer is a system for rapidly aligning entire genomes, whether in complete or draft form.'
  name 'mummer'
  version '3.23' 
  revision 0
  homepage 'http://mummer.sourceforge.net/'
  source "http://sourceforge.net/projects/mummer/files/mummer/#{version}/MUMmer#{version}.tar.gz"
  md5 'f2422b3d2638dba4baedb71b1acdffa2'

  # Let's install build dependencies first.
  build_depends ['make', 'csh', 'g++']

  # Build:
  def build
    safesystem 'make check'
    safesystem 'make install'
  end

  # Install:
  def install
    bin.install ['mummer', 'nucmer', 'promer', 'run-mummer1', 'run-mummer3']
  end
end
