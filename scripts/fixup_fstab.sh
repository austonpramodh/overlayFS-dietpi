sed -i.orig -e "s/\(PARTUUID.*\)\(rw\)/\1ro/" /etc/fstab
sed -i.orig -e "s/\(UUID.*\)\(rw\)/\1ro/" /etc/fstab # VM testing!
echo "mount_overlay	/home	fuse	nofail,defaults	0	0" >>/etc/fstab
echo "mount_overlay	/root	fuse	nofail,defaults	0	0" >>/etc/fstab
echo "mount_overlay	/var	fuse	nofail,defaults	0	0" >>/etc/fstab
echo "none		/tmp	tmpfs	defaults	0	0" >>/etc/fstab
systemctl daemon-reload