class IGV < FPM::Cookery::Recipe
  description 'IGV is a high-performance visualization tool for interactive exploration of large, integrated genomic datasets.'
  name 'igv'
  version '2.3.59' 
  revision 0
  homepage 'https://www.broadinstitute.org/igv/'
  source "http://data.broadinstitute.org/igv/projects/downloads/IGV_#{version}.zip"
  md5 'b9610afb3bdca99defaef9d3bbf3bc40'

  depends ['curl', 'default-jre', 'default-jdk', 'icnsutils']

  def build
  end

  def install
    Dir.chdir "IGV_#{version}" do
      File.open('IGV.desktop', 'w', 0755) do |f|
        f.write <<-__EOF
[Desktop Entry]
Type=Application
Name=IGV
Comment=Interactive Genomics Viewer
Exec=igv.sh
Icon=igv_icon
Terminal=true
StartupNotify=false
Categories=Graphics;Science;Math
        __EOF
      end
    end
    
    etc('skel/Desktop').mkdir
    etc('skel/Desktop').install Dir["IGV_#{version}/IGV.desktop"]
    share('icons/hicolor/48x48/apps/').install workdir('igv_icon.png')
    bin.install Dir["IGV_#{version}/*"]
  end
end
