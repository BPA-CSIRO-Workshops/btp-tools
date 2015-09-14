class Subread < FPM::Cookery::Recipe
  description 'high-performance read alignment, quantification and mutation discovery.'
  name 'subread'
  version '1.4.6-p4' 
  revision 0
  homepage 'http://subread.sourceforge.net/'
  source "http://sourceforge.net/projects/subread/files/subread-1.4.6-p4/subread-#{version}-source.tar.gz"
  md5 '2ad116fe3e76c9d4f9f0481419681e20'

  build_depends ['make', 'gcc', 'zlib1g', 'zlib1g-dev', 'wget']

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
