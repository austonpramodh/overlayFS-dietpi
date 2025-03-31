TMPFS_PREFIX="/overlays"
ORIGFS_PREFIX="/orig_fs"

for D in /var /root /home
do
	TMPFS_DIR_ROOT="${TMPFS_PREFIX}${D}"
	ORIGFS_DIR_ROOT="${ORIGFS_PREFIX}${D}"

	mv -v ${D} ${ORIGFS_DIR_ROOT}_org
	cd ${ORIGFS_DIR_ROOT}_org
	find . | cpio -pdum ${ORIGFS_DIR_ROOT}_stage
	mkdir -v ${D} ${TMPFS_DIR_ROOT}_rw ${D}/.overlaysync ${ORIGFS_DIR_ROOT}_org/.overlaysync
done
exit
