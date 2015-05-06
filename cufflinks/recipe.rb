class Cufflinks < FPM::Cookery::Recipe
  description 'Cufflinks assembles transcripts, estimates their abundances, and tests for differential expression and regulation in RNA-Seq samples.'
  name 'cufflinks'
  version '2.2.1' 
  revision 0
  homepage 'http://cole-trapnell-lab.github.io/cufflinks/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/cufflinks-#{version}.tar.gz"
  md5 '9a5ba7a7710cd864932cf205c17851f0'
  
  build_depends ['libeigen3-dev', 'libeigen3-doc']

  def build
    cp_r Dir['/usr/include/eigen3/Eigen'], '/usr/include/'
    configure :prefix => prefix
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
