# DO NOT EDIT THIS FILE
#
# Please edit /boot/armbianEnv.txt to set supported parameters
#
setenv rootdev "/dev/mmcblk1p1"
setenv rootfs "ext4"
setenv verbosity "1"
setenv devtype "mmc"
setenv prefix "boot/"

echo "Boot script loaded from device ${devnum}"

if test -e ${devtype} ${devnum} ${prefix}armbianEnv.txt; then
	load ${devtype} ${devnum} ${kernel_addr_r} ${prefix}armbianEnv.txt
	env import -t ${kernel_addr_r} ${filesize}
fi


setenv bootargs "console=ttyS2,115200n1 root=${rootdev} rw rootfstype=${rootfs} rootwait audit=0 loglevel=${verbosity}"
ext4load ${devtype} ${devnum}:${mmcpart} ${fdtaddr} ${mmcfdtfile}
ext4load ${devtype} ${devnum}:${mmcpart} ${rdaddr} ${mmcinitrdfile}
ext4load ${devtype} ${devnum}:${mmcpart} ${kernel_addr_r} ${mmckernfile}
echo "Booting ${mmckernfile} ${mmcinitrdfile} ${mmcfdtfile} from: ${devtype} ${devnum}:${mmcpart} using bootargs=${bootargs}"
bootz ${kernel_addr_r} ${rdaddr} ${fdtaddr}
# Recompile with:
# mkimage -C none -A arm -T script -d /boot/boot.cmd /boot/boot.scr
