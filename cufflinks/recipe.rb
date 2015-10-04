class Cufflinks < FPM::Cookery::Recipe
  description 'Cufflinks assembles transcripts, estimates their abundances, and tests for differential expression and regulation in RNA-Seq samples.'
  name 'cufflinks'
  version '2.2.1' 
  revision 0
  homepage 'http://cole-trapnell-lab.github.io/cufflinks/'
  source "http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-#{version}.Linux_x86_64.tar.gz"
  md5 '7e693d182dcfda8aeef8523219ea9ea7'

  # Let's install build dependencies first.
  build_depends ['curl']

  # Build:
  def build
  end

  # Install.
  def install
    bin.install ['cufflinks', 'cuffcompare', 'gffread', 'cuffmerge', 'cuffdiff', 'gtf_to_sam', 'cuffnorm', 'cuffquant']
  end
end
