class IGVTools < FPM::Cookery::Recipe
  description 'The igvtools utility provides a set of tools for pre-processing data files. '
  name 'igvtools'
  version '2.3.57' 
  revision 0
  homepage 'https://www.broadinstitute.org/igv/igvtools'
  source "http://data.broadinstitute.org/igv/projects/downloads/igvtools_#{version}.zip"
  md5 '68a3230698bd530544ced92414d45c33'

  # Let's install build dependencies first.
  depends ['curl', 'default-jre', 'default-jdk']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["IGVTools/*"]
  end
end
