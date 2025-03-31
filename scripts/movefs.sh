TMPFS_PREFIX="/overlays"
ORIGFS_PREFIX="/orig_fs"

for DIR in /var /root /home
do
	TMPFS_DIR_ROOT="${TMPFS_PREFIX}${DIR}_rw"
	ORIGFS_DIR_ROOT="${ORIGFS_PREFIX}${DIR}_org"

	mv -v ${D} ${ORIGFS_DIR_ROOT}
	cd ${ORIGFS_DIR_ROOT}
	find . | cpio -pdum ${ORIGFS_DIR_ROOT}_stage
	mkdir -p -v ${D} ${TMPFS_DIR_ROOT} ${D}/.overlaysync ${ORIGFS_DIR_ROOT}/.overlaysync
done
exit
