sed -i.orig -e "s/\(PARTUUID.*\)\(rw\)/\1ro/" /etc/fstab
# sed -i.orig -e "s/\(UUID.*\)\(rw\)/\1ro/" /etc/fstab # VM testing!
echo "tmpfs         /overlays   tmpfs   size=512M,nofail,defaults  0   0" >>/etc/fstab
echo "mount_overlay	/home	    fuse	size=512M,nofail,defaults	0	0" >>/etc/fstab
echo "mount_overlay	/home	    fuse	size=512M,nofail,defaults	0	0" >>/etc/fstab
echo "mount_overlay	/root	    fuse	size=512M,nofail,defaults	0	0" >>/etc/fstab

systemctl daemon-reload