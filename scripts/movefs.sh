#!/bin/bash

TMPFS_PREFIX="/overlays"
ORIGFS_PREFIX="/orig_fs"

echo "Creating ${ORIGFS_PREFIX}"
mkdir -pv ${ORIGFS_PREFIX}

echo "Creating ${TMPFS_PREFIX}"
mkdir -pv ${TMPFS_PREFIX}

for DIR in /var /root /home
do
	TMPFS_DIR_ROOT="${TMPFS_PREFIX}${DIR}_rw"
	ORIGFS_DIR_ROOT="${ORIGFS_PREFIX}${DIR}"
	echo "-----Moving ${DIR}...-----"
	mv -v ${DIR} ${ORIGFS_DIR_ROOT}_org
	cd ${ORIGFS_DIR_ROOT}_org
	find . | cpio -pdum ${ORIGFS_DIR_ROOT}_stage
	mkdir -p -v ${DIR} ${TMPFS_DIR_ROOT} ${DIR}/.overlaysync ${ORIGFS_DIR_ROOT}_org/.overlaysync
done
exit