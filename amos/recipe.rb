class AMOS < FPM::Cookery::Recipe
  description 'AMOS is a collection of tools for genome assembly.'
  name 'amos'
  version '3.1.0' 
  revision 0
  homepage 'http://sourceforge.net/projects/amos/'
  source "http://sourceforge.net/projects/amos/files/amos/#{version}/amos-#{version}.tar.gz"
  md5 '51ebe835c93eef9acd39101738b2048c'

  build_depends ['gcc', 'autoconf']

  def build
    configure :prefix => prefix,
      :enable_minimus => false
    make
  end

  def install
    make :install, 'DESTDIR' => destdir
  end
end
