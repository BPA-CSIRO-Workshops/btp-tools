class MACS < FPM::Cookery::Recipe
  description 'Model-based Analysis of ChIP-Seq (MACS) on short reads sequencers such as Genome Analyzer (Illumina / Solexa).'
  name 'macs'
  version '1.4.2'
  revision 0
  homepage 'http://liulab.dfci.harvard.edu/MACS/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/MACS-#{version}-1.tar.gz"
  md5 '950dab09fe1335c8bbb34a896c21e3e2'

  def build
  end

  def install
    linktarget = bin('macs')
    with_trueprefix do
      safesystem "python setup.py install --root #{destdir} --prefix #{prefix} --install-layout deb"
      ln_s 'macs14', linktarget
    end
  end
end
