class MACS < FPM::Cookery::Recipe
  description 'Model-based Analysis of ChIP-Seq (MACS) on short reads sequencers such as Genome Analyzer (Illumina / Solexa).'
  name 'macs'
  version '1.4.2-1'
  revision 0
  homepage 'http://liulab.dfci.harvard.edu/MACS/'
  source "https://github.com/downloads/taoliu/MACS/MACS-#{version}.tar.gz"
  md5 '950dab09fe1335c8bbb34a896c21e3e2'

  # Let's install build dependencies first.
  build_depends ['curl', 'python']
  depends ['python']

  # Build.
  def build
  end

  # Install.
  def install
    linktarget = bin('macs')
    with_trueprefix do
      safesystem "python setup.py install --root #{destdir} --prefix #{prefix} --install-layout deb"
      ln_s 'macs14', linktarget
    end
  end
end
