#!/bin/bash

TMPFS_PREFIX="/overlays"
ORIGFS_PREFIX="/orig_fs"

for DIR in /var /root /home
do
	TMPFS_DIR_ROOT="${TMPFS_PREFIX}${DIR}_rw"
	ORIGFS_DIR_ROOT="${ORIGFS_PREFIX}${DIR}"

	mv -v ${DIR} ${ORIGFS_DIR_ROOT}_org
	cd ${ORIGFS_DIR_ROOT}_org
	find . | cpio -pdum ${ORIGFS_DIR_ROOT}_stage
	mkdir -p -v ${DIR} ${TMPFS_DIR_ROOT} ${DIR}/.overlaysync ${ORIGFS_DIR_ROOT}_org/.overlaysync
done
exit