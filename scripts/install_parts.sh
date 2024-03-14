mv saveoverlays-bookworm saveoverlays
chmod a+rx saveoverlays mount_overlay rootro movefs.sh fixup_fstab.sh
cp mount_overlay /usr/local/bin/
cp saveoverlays /etc/init.d/ 
cp rootro /usr/local/bin/ 
ln -s rootro /usr/local/bin/rootrw 
cp syncoverlayfs.service /lib/systemd/system/

mv /etc/wpa_supplicant/wpa_supplicant.conf /var/local/
ln -s /var/local/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
mv /etc/resolv.conf /var/local/
ln -s /var/local/resolv.conf /etc/resolv.conf
touch /var/local/resolv.conf.bak
rm /etc/resolv.conf.bak
ln -s /var/local/resolv.conf.bak /etc/resolv.conf.bak
mv /etc/fake-hwclock.data /var/local/
ln -s /var/local/fake-hwclock.data /etc/fake-hwclock.data
touch /var/local/mtab
rm /etc/mtab
ln -s /var/local/mtab /etc/mtab

