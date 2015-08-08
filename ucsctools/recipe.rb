class UCSCTools < FPM::Cookery::Recipe
  description 'UCSC Tools.'
  name 'ucsctools'
  version '319' 
  revision 0
  homepage 'http://hgdownload.cse.ucsc.edu/admin/exe/'
  source "http://hgdownload.soe.ucsc.edu/admin/exe/userApps.v#{version}.src.tgz"
  md5 '68bbe3de3377d82ae0711653cc302d1e'

  def build
    make
  end

  def install
    bin.install Dir['bin/*']
  end
end
