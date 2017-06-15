class IGVTools < FPM::Cookery::Recipe
  description 'The igvtools utility provides a set of tools for pre-processing data files. '
  name 'igvtools'
  version '2.3.94' 
  revision 0
  homepage 'https://www.broadinstitute.org/igv/igvtools'
  source "http://data.broadinstitute.org/igv/projects/downloads/igvtools_#{version}.zip"
  md5 'b7faea83f121246a1e9bf03f26ba52ee'

  # Let's install build dependencies first.
  depends ['default-jre', 'default-jdk']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir["IGVTools/*"]
  end
end
