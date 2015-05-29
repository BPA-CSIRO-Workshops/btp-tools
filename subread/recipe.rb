class Subread < FPM::Cookery::Recipe
  description 'high-performance read alignment, quantification and mutation discovery.'
  name 'subread'
  version '1.4.6-p3' 
  revision 0
  homepage 'http://subread.sourceforge.net/'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/subread-#{version}-source.tar.gz"
  md5 '18a6f9af69a5825651f32148b44f1919'

  def build
    Dir.chdir "src" do
      safesystem 'make -f Makefile.Linux'
    end
  end

  def install
    Dir.chdir "bin" do
      bin.install ['featureCounts', 'exactSNP', 'subread-buildindex', 'subread-align', 'subindel', 'subjunc']
      bin.install Dir['utilities/*']
    end
  end
end
