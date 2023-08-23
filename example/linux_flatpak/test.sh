cd ..
sh linux_flatpak/build-linux.sh
cd linux_flatpak || exit
flatpak-builder --user --install --force-clean build-dir com.llfbandit.example.yml
flatpak run com.llfbandit.example