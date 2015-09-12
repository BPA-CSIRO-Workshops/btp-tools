class PeakAnalyzer < FPM::Cookery::Recipe
  description 'PeakAnalyzer is a set of standalone programs for the automated processing of any genomic loci, with an emphasis on datasets consisting of ChIP-derived signal peaks. '
  name 'peakanalyzer'
  version '1.4' 
  revision 0
  homepage 'http://www.bioinformatics.org/peakanalyzer/wiki/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/PeakAnalyzer_#{version}.tar.gz"
  md5 'd66d414aae2d912786a26f8e35d1b2ae'

  build_depends ['curl']

  def build
  end

  def install
    bin.install ['PeakAnalyzer.jar', 'PeakAnalyzerGUI.jar']
  end
end
