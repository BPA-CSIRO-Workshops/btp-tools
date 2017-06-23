class MUMmer < FPM::Cookery::Recipe
  description 'MUMmer is a system for rapidly aligning entire genomes, whether in complete or draft form.'
  name 'mummer'
  version '3.23' 
  revision 0
  homepage 'http://mummer.sourceforge.net/'
  source "http://sourceforge.net/projects/mummer/files/mummer/#{version}/MUMmer#{version}.tar.gz"
  md5 'f2422b3d2638dba4baedb71b1acdffa2'

  # Let's install build dependencies first.
  build_depends ['make', 'csh', 'g++', 'gcc']

  # Build:
  def build
    safesystem 'make check'
    safesystem 'make install'
  end

  # Install:
  def install
    inline_replace 'dnadiff' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'exact-tandems' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'mapview' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'mummerplot' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'nucmer' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'promer' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'run-mummer1' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    inline_replace 'run-mummer3' do |s|
      s.gsub! "#{builddir}/MUMmer3.23", '/usr/bin'
    end

    bin.install Dir['scripts', 'aux_bin']
    bin.install ['annotate', 'combineMUMs', 'delta-filter', 'dnadiff', 'exact-tandems', 'gaps', 'mapview', 'mgaps', 'mummerplot', 'mummer', 'nucmer', 'nucmer2xfig', 'promer', 'repeat-match', 'run-mummer1', 'run-mummer3', 'show-aligns', 'show-coords', 'show-diff', 'show-snps', 'show-tiling']
  end
end
