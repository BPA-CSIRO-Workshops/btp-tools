class GNXTools < FPM::Cookery::Recipe
  description 'Genome basic statistics tool.'
  name 'gnx-tools'
  version '0.0.1'
  revision 0
  homepage 'https://github.com/mh11/gnx-tools'
  source 'https://github.com/mh11/gnx-tools.git', :with => :git

  # Let's install build dependencies first.
  build_depends ['default-jre', 'default-jdk', 'ant', 'git']
  depends ['default-jre', 'default-jdk']

  # Build:
  def build
    safesystem 'mkdir bin'
    safesystem 'javac -d bin/ src/uk/ac/ebi/gnx/*'
    safesystem 'ant -f package.xml'

    File.open('gnx', 'w', 0755) do |f|
      f.write <<-__EOF
#!/bin/sh

# Simple wrapper to run gnx-tools
exec java -jar /usr/share/java/gnx.jar "$@"
      __EOF
    end
  end

  # Install:
  def install
    share('java').install 'gnx.jar'
    bin.install 'gnx'
  end
end
