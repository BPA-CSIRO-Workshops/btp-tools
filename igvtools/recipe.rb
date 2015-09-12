class IGVTools < FPM::Cookery::Recipe
  description 'The igvtools utility provides a set of tools for pre-processing data files. '
  name 'igvtools'
  version '2.3.40' 
  revision 0
  homepage 'https://www.broadinstitute.org/igv/igvtools'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/igvtools_#{version}.zip"
  md5 '2b8712ef79b2c903f6f3383e20416f72'

  depends ['curl', 'openjdk-7-jre', 'java7-runtime']

  def build
  end

  def install
    bin.install Dir["IGVTools/*"]
  end
end
