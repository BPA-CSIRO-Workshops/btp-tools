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
    share('java').install 'pilon-1.22.jar'

    link_target = share('java/pilon.jar')

    with_trueprefix do
      ln_s share('java/pilon-1.22.jar'), link_target
    end
  end
end
