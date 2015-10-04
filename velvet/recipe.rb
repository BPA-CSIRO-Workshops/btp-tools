class Velvet < FPM::Cookery::Recipe
  description 'Sequence assembler for very short reads.'
  name 'velvet'
  version '1.2.10'
  revision 0
  homepage 'https://www.ebi.ac.uk/~zerbino/velvet/'
  source "https://www.ebi.ac.uk/~zerbino/velvet/velvet_#{version}.tgz"
  md5 '6e28c4b9bedc5f7ab2b947e7266a02f6'

  # Let's install build dependencies first:
  build_depends ['curl', 'zlib1g-dev']

  # Build:
  def build
    safesystem "make 'MAXKMERLENGTH=59' 'LONGSEQUENCES=1' 'OPENMP=1'"
  end

  # Install:
  def install
    velvetg_long = bin('velvetg_long')
    velveth_long = bin('velveth_long')
    bin.install ['velvetg', 'velveth']
    ln_s 'velvetg', velvetg_long
    ln_s 'velveth', velveth_long
  end
end
