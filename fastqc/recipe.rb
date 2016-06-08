class FastQC < FPM::Cookery::Recipe
  description 'FastQC is a quality control tool for high throughput sequence data.'
  name 'fastqc'
  version '0.11.5' 
  revision 0
  homepage 'http://www.bioinformatics.babraham.ac.uk/projects/fastqc/'
  source "http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v#{version}.zip"
  md5 '3524f101c0ab0bae77c7595983170a76'

  # Let's install build dependencies first:
  build_depends ['curl', 'g++', 'unzip', 'wget']
  depends ['default-jre', 'default-jdk']

  # Build:
  def build
  end

  # Install:
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
