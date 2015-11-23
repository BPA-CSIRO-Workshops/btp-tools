class IGVTools < FPM::Cookery::Recipe
  description 'The igvtools utility provides a set of tools for pre-processing data files. '
  name 'igvtools'
  version '2.3.59' 
  revision 0
  homepage 'https://www.broadinstitute.org/igv/igvtools'
  source "http://data.broadinstitute.org/igv/projects/downloads/igvtools_#{version}.zip"
  md5 '1369e1b4a0628848c708835f4cc601ca'

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
