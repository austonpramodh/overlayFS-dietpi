# DietPi overlayFS 
Files required to bring in overlayFS functionality to DietPi
in hopes to reduce writes to SD cards, and prevent corruption
on unexpected power-down.

Works with DietPi Bookworm!


# Installation

1. Disable Swap - `sudo /boot/dietpi/func/dietpi-set_swapfile 0`

1. Install Packages - `sudo apt update && sudo apt install fuse lsof`

1. Fetch Utility an files
    ```
    cd /tmp
    wget https://github.com/austonpramodh/overlayFS-dietpi/raw/dev/scripts/get_files.sh
    chmod a+rx get_files.sh
    ./get_files.sh
    ```

1. Run Install Parts - `./install_parts.sh`

1. Enable the service
    ```
    systemctl daemon-reload
    systemctl enable syncoverlayfs.service
    ```

1. Change the boot commandline - `sed -i.bak -e "s/$/ noswap fastboot ro/" /boot/cmdline.txt`

1. Update fstab - `./fixup_fstab.sh`

1. Prepare the overlays directories

    This can take a LONG time to complete, at least 20 minutes on a fast SD card.

    ```
    ./movefs.sh
    ```
1. Add bash prompt indicator for rootfs read-only mode on terminal
    ```sh
    echo "
    set_bash_prompt() {
        # fs_mode=$(mount | sed -n -e "s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p")
        fs_mode=\$(mount | sed -n -e \"s/^\/dev\/.* on \/ .*(\(r[w|o]\).*/\1/p\")
        # PS1='\[\033[01;32m\]\u@\h${fs_mode:+($fs_mode)}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        PS1='\[\033[01;32m\]\u@\h\${fs_mode:+(\$fs_mode)}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '
    }
    PROMPT_COMMAND=set_bash_prompt

    alias syncoverlay='sudo /etc/init.d/saveoverlays sync'

    " >> /etc/bash.bashrc
    ```