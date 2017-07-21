class Delly < FPM::Cookery::Recipe
  description 'Delly2 - Structural variant discovery by integrated paired-end and split-read analysis'
  name 'delly'
  version '0.6.7' 
  revision 0
  homepage 'https://github.com/dellytools/delly'
  source "https://github.com/dellytools/delly/releases/download/v#{version}/delly_v#{version}_linux_x86_64bit"
  md5 'a9a2335caf3121d317c70ac2ecc680dc'

  # Let's install build dependencies first.
  build_depends ['curl', 'wget']

  # Build:
  def build
  end

  # Install:
  def install
    chmod 0755, "delly_v#{version}_linux_x86_64bit"
    mv "delly_v#{version}_linux_x86_64bit", 'delly'
    bin.install 'delly'
  end
end
