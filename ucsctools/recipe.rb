class UCSCTools < FPM::Cookery::Recipe
  description 'UCSC Tools.'
  name 'ucsctools'
  version '310' 
  revision 0
  homepage 'http://hgdownload.cse.ucsc.edu/admin/exe/'
  source "http://hgdownload.soe.ucsc.edu/admin/exe/userApps.v#{version}.src.tgz"
  md5 '718d5368cca8aee08961489d987b1be5'

  def build
    make
  end

  def install
    bin.install Dir['bin/*']
  end
end
