class FastQC < FPM::Cookery::Recipe
  description 'FastQC is a quality control tool for high throughput sequence data.'
  name 'fastqc'
  version '0.11.2' 
  revision 0
  homepage 'http://www.bioinformatics.babraham.ac.uk/projects/fastqc/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/fastqc_v#{version}.zip"
  md5 '8686e180a2d7c818821eb7db194d9488'

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
