#
#Disable Swap
# dphys-swapfile swapoff
# dphys-swapfile uninstall
# systemctl disable dphys-swapfile
/boot/dietpi/func/dietpi-set_swapfile 0 # Dietpi way of disabling swap


#Fetch files and install apt packages
wget https://github.com/austonpramodh/overlayFS-dietpi/raw/master/scripts/get_files.sh
chmod a+rx get_files.sh
./get_files.sh
apt-get -y install fuse lsof

#start the installs
./install_parts.sh
systemctl daemon-reload
systemctl enable syncoverlayfs.service

#fixup /boot/cmdline.txt
# sed -i.bak -e "s/$/ noswap fastboot ro/" /boot/cmdline.txt # No /boot/cmdline.txt in dietpi

#update fstab
./fixup_fstab.sh

#move fs
echo "Long Operation in progress, moving filesystems"
./movefs.sh

#mounts
mount /home
mount /root
mount /var

echo "Install Complete, reboot to continue"
