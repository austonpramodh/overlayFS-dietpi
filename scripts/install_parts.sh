mv saveoverlays-bookworm saveoverlays
chmod a+rx saveoverlays mount_overlay rootro movefs.sh fixup_fstab.sh
cp mount_overlay /usr/local/bin/
cp saveoverlays /etc/init.d/ 
cp rootro /usr/local/bin/ 
ln -s rootro /usr/local/bin/rootrw 
cp syncoverlayfs.service /lib/systemd/system/

# If wpa_supplicant.conf exists, move it to /var/local else create wpa_supplicant.conf at /var/local
if [ -f /etc/wpa_supplicant/wpa_supplicant.conf ]; then
    echo "wpa_supplicant.conf exists, moving to /var/local/"
    mv /etc/wpa_supplicant/wpa_supplicant.conf /var/local/
else
    echo "wpa_supplicant.conf does not exist, creating at /var/local/"
    mkdir -p /etc/wpa_supplicant/
    touch /var/local/wpa_supplicant.conf
fi

ln -s /var/local/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
mv /etc/resolv.conf /var/local/
ln -s /var/local/resolv.conf /etc/resolv.conf
touch /var/local/resolv.conf.bak

if [ -f /etc/resolv.conf.bak ]; then
    echo "resolv.conf.bak exists, moving to /var/local/"
    mv /etc/resolv.conf.bak /var/local/
fi

ln -s /var/local/resolv.conf.bak /etc/resolv.conf.bak
mv /etc/fake-hwclock.data /var/local/
ln -s /var/local/fake-hwclock.data /etc/fake-hwclock.data
touch /var/local/mtab
rm /etc/mtab
ln -s /var/local/mtab /etc/mtab

