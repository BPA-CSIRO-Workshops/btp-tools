class FastQC < FPM::Cookery::Recipe
  description 'FastQC is a quality control tool for high throughput sequence data.'
  name 'fastqc'
  version '0.11.3' 
  revision 0
  homepage 'http://www.bioinformatics.babraham.ac.uk/projects/fastqc/'
  source "http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v#{version}_source.zip"
  md5 '80b3ad1af0a2b2594318857ed7d7c237'

  # Let's install build dependencies first.
  build_depends ['curl', 'g++', 'unzip', 'wget']

  def build
  end

  def install
    bin.mkdir
    prefix('local/fastqc').mkdir
    cp_r Dir['FastQC/*'], prefix('local/fastqc').to_s
    chmod 0755, prefix('local/fastqc/fastqc')

    link_target = bin('fastqc')

    with_trueprefix do
      ln_s prefix('local/fastqc/fastqc'), link_target
    end
  end
end
