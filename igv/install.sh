#!/bin/bash

install_dir='/usr/local/tools'
tool_location='http://data.broadinstitute.org/igv/projects/downloads/IGV_2.3.59.zip'
tool_name='igv'
md5='b9610afb3bdca99defaef9d3bbf3bc40'

function md5check {
  md5sum -c - <<< "$1 $2"
  if [ $? -ne 0 ]; then
    echo "MD5 mismatch on downloaded file, exiting ..."
    exit
  fi
}

##################
## Dependencies ##
##################
dependencies=(default-jre default-jdk ant icnsutils unzip)
apt-get update
apt-get install -y ${dependencies[@]}
apt-get clean

#########
## IGV ##
#########
if [ ! -e "$install_dir/$tool_name" ]; then
  echo "Creating installation directory for $tool_name"
  mkdir -p "$install_dir/$tool_name"
else
  echo "Installation directory for $tool_name already exists"
fi

cd $install_dir/$tool_name

if [ ! -f IGV_2.3.59.zip ]; then
  wget -4 --no-check-certificate $tool_location
fi

md5check $md5 IGV_2.3.59.zip
unzip IGV_2.3.59.zip
mv IGV_2.3.59 default

# Icons
cd default
if [ ! -f v2.3.59.zip ]; then
  wget -4 https://github.com/igvteam/igv/archive/v2.3.59.zip
fi

md5check '8a9572903712b152ac63d441ba1766c5' v2.3.59.zip
unzip v2.3.59.zip
mv igv-2.3.59 src
cd src/resources
icns2png -x igv_icon.icns 
cp igv_icon_16x16x32.png /usr/share/icons/hicolor/16x16/apps/igv_icon.png
cp igv_icon_32x32x32.png /usr/share/icons/hicolor/32x32/apps/igv_icon.png
cp igv_icon_48x48x32.png /usr/share/icons/hicolor/48x48/apps/igv_icon.png
cp igv_icon_128x128x32.png /usr/share/icons/hicolor/128x128/apps/igv_icon.png
cp igv_icon_256x256x32.png /usr/share/icons/hicolor/256x256/apps/igv_icon.png

# Desktop Shortcut
mkdir -p /etc/skel/Desktop
echo "[Desktop Entry]" >> /etc/skel/Desktop/IGV.desktop
echo "Type=Application" >> /etc/skel/Desktop/IGV.desktop
echo "Name=IGV" >> /etc/skel/Desktop/IGV.desktop
echo "Comment=Interactive Genomics Viewer" >> /etc/skel/Desktop/IGV.desktop
echo "Exec=igv.sh" >> /etc/skel/Desktop/IGV.desktop
echo "Icon=igv_icon" >> /etc/skel/Desktop/IGV.desktop
echo "Terminal=true" >> /etc/skel/Desktop/IGV.desktop
echo "StartupNotify=false" >> /etc/skel/Desktop/IGV.desktop
echo "Categories=Graphics;Science;Math" >> /etc/skel/Desktop/IGV.desktop
####################

#################
## Setup Paths ##
#################
chown -R root.root $install_dir/$tool_name
echo "if ! echo \${PATH} | /bin/grep -q $install_dir/$tool_name/default ; then" > /etc/profile.d/$tool_name.sh
echo "PATH=$install_dir/$tool_name/default:\${PATH}" >> /etc/profile.d/$tool_name.sh
echo "fi" >> /etc/profile.d/$tool_name.sh
