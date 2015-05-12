class UCSCTools < FPM::Cookery::Recipe
  description 'Bowtie is an ultrafast and memory-efficient short read aligner.'
  name 'ucsctools'
  version '310' 
  revision 0
  homepage 'http://hgdownload.cse.ucsc.edu/admin/exe/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/userApps.v#{version}.src.tgz"
  md5 '718d5368cca8aee08961489d987b1be5'

  def build
    make
  end

  def install
    bin.install Dir['bin/*']
  end
end
