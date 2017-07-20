class Gemini < FPM::Cookery::Recipe
  description 'GEMINI: a flexible framework for exploring genome variation'
  name 'gemini'
  version '0.20.0' 
  revision 0
  homepage 'http://gemini.readthedocs.io/'
  source "https://github.com/arq5x/gemini.git", :with => :git
  #md5 'fdb174bbd721496569c756065e6b3033'

  # Let's install build dependencies first.
  build_depends ['curl', 'python']

  # Build:
  def build
  end

  # Install:
  def install
    with_trueprefix do
      safesystem "python setup.py install --root #{destdir} --prefix #{prefix} --install-layout deb"
    end
  end
end
