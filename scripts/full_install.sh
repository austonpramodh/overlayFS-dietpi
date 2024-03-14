#
#Disable Swap
# dphys-swapfile swapoff
# dphys-swapfile uninstall
# systemctl disable dphys-swapfile
/boot/dietpi/func/dietpi-set_swapfile 0 # Dietpi way of disabling swap


#Fetch files and install apt packages
wget https://github.com/austonpramodh/overlayFS-dietpi/raw/dev/scripts/get_files.sh
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

# Add in indicator for rootfs read-only mode on terminal
echo "
set_bash_prompt() {
    fs_mode=$(mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p")
    PS1='\[\033[01;32m\]\u@\h${fs_mode:+($fs_mode)}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}
#alias ro='sudo mount -o remount,ro / ; sudo mount -o remount,ro /boot'
#alias rw='sudo mount -o remount,rw / ; sudo mount -o remount,rw /boot'
PROMPT_COMMAND=set_bash_prompt

alias syncoverlay='sudo /etc/init.d/saveoverlays sync'
" >> /etc/bash.bashrc

echo "Install Complete, reboot to continue"
