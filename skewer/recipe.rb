class Skewer < FPM::Cookery::Recipe
  description 'A fast and sensitive adapter trimmer for illumina paired-end sequences.'
  name 'skewer'
  version '0.0.1' 
  revision 0
  homepage 'https://github.com/relipmoc/skewer'
  source 'https://github.com/relipmoc/skewer.git', :with => :git

  # Let's install build dependencies first.
  build_depends ['make', 'g++', 'git']

  def build
    inline_replace 'Makefile' do |s|
      s.gsub! 'LDFLAGS=-pthread -lrt', 'LDFLAGS=-pthread'
      s.gsub! '$(CXX) $(LDFLAGS) $(OBJECTS) -o $@', '$(CXX) $(LDFLAGS) $(OBJECTS) -o $@ -lrt'
    end
    make
  end

  def install
    bin.install 'skewer'
  end
end
