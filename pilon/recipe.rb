class Pilon < FPM::Cookery::Recipe
  description 'Pilon is an automated genome assembly improvement and variant detection tool.'
  name 'pilon'
  version '1.22'
  revision 0
  homepage 'https://github.com/broadinstitute/pilon'
  source "https://github.com/broadinstitute/pilon/releases/download/v#{version}/pilon-#{version}.jar"
  md5 '3c45568dc1b878a9a0316410ec62ab04'

  # Let's install build dependencies first:
  depends ['default-jre', 'default-jdk']

  # Build:
  def build
  end

  # Install:
  def install
    File.open('pilon', 'w', 0755) do |f|
      f.write <<-__EOF
#!/bin/sh
prefix=`dirname $(readlink $0 || echo $0)`
java -Xmx4G -jar "$prefix"/pilon.jar "$@"
      __EOF
    end

    bin.install 'pilon'
    bin.install 'pilon-1.22.jar'
    link_target = bin('pilon.jar')

    with_trueprefix do
      ln_s bin('pilon-1.22.jar'), link_target
    end
  end
end
