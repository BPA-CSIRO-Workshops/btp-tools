class IGV < FPM::Cookery::Recipe
  description 'IGV is a high-performance visualization tool for interactive exploration of large, integrated genomic datasets.'
  name 'igv'
  version '2.3.40'
  revision 0
  homepage 'https://www.broadinstitute.org/igv/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/IGV_#{version}.zip"
  md5 '93aee7bfe878e20263e1e3cbcaa6739d'

  depends ['openjdk-7-jre', 'java7-runtime']

  def build
  end

  def install
    bin.install Dir["IGV_#{version}/*"]
  end
end
