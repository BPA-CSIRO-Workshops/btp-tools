class Blat < FPM::Cookery::Recipe
  description 'Blat is an alignment tool like BLAST, but it is structured differently.'
  name 'blat'
  version '35' 
  revision 0
  homepage 'https://genome.ucsc.edu/FAQ/FAQblat.html'
  source "https://swift.rc.nectar.org.au:8888/v1/AUTH_809/Tools/blatSrc35.zip"
  md5 '16e546b8843b85e0b0f2fa603cd78724'

  build_depends ['libpng12-dev']

  def build
    Dir.chdir 'blatSrc' do
      Dir.mkdir 'bin'
      inline_replace 'inc/common.mk' do |s|
        s.gsub! 'BINDIR = ${HOME}/bin/${MACHTYPE}', "BINDIR=#{Dir.pwd}/bin"
      end
      safesystem 'make MACHTYPE=x86_64'
    end
  end

  def install
    Dir.chdir 'blatSrc/bin' do
      bin.install ['blat', 'faToNib', 'faToTwoBit', 'gfClient', 'gfServer', 'nibFrag', 'pslPretty', 'pslReps', 'pslSort', 'twoBitInfo', 'twoBitToFa']
    end
  end
end
