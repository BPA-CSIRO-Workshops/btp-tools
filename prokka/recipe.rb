class Prokka < FPM::Cookery::Recipe
  description 'rapid prokaryotic genome annotation.'
  name 'prokka'
  version '1.12'
  revision 0
  homepage 'https://github.com/tseemann/prokka'
  source "https://github.com/tseemann/prokka.git", :with => :git

  # Let's install build dependencies first:
  depends ['git']

  # Build:
  def build
  end

  # Install:
  def install
    bin.install Dir['bin/*']
    prefix.install Dir['binaries', 'db', 'doc', 'perl5']
  end
end
