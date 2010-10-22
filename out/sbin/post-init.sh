#!/sbin/busybox sh
# filesystem patcher
# Copyright SztupY, Licence: GPLv3

export PATH=/sbin:/system/bin:/system/xbin
mv /system/user.log /system/user.log.old
exec >>/system/user.log
exec 2>&1

# init read-only'd the rootfs
/sbin/busybox mount -o remount,rw /

# run fs tweaks
if /sbin/busybox [ "`grep IOSCHED /system/etc/tweaks.conf`" ]; then
  # Tweak cfq io scheduler
  for i in $(ls -1 /sys/block/stl*) $(ls -1 /sys/block/mmc*) $(ls -1 /sys/block/bml*) $(ls -1 /sys/block/tfsr*)
  do echo "0" > $i/queue/rotational
    echo "1" > $i/queue/iosched/low_latency
    echo "1" > $i/queue/iosched/back_seek_penalty
    echo "1000000000" > $i/queue/iosched/back_seek_max
    echo "3" > $i/queue/iosched/slice_idle
  done
fi

# Tweak kernel VM management
if /sbin/busybox [ "`grep KERNELVM /system/etc/tweaks.conf`" ]; then
  echo "0" > /proc/sys/vm/swappiness
  echo "10" > /proc/sys/vm/dirty_ratio
  echo "1000" > /proc/sys/vm/vfs_cache_pressure
  echo "4096" > /proc/sys/vm/min_free_kbytes
fi

# Tweak kernel scheduler
if /sbin/busybox [ "`grep KERNELSCHED /system/etc/tweaks.conf`" ]; then
  echo "4000000" > /proc/sys/kernel/sched_latency_ns
  echo "1000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
  echo "800000" > /proc/sys/kernel/sched_min_granularity_ns
fi

# Miscellaneous tweaks
if /sbin/busybox [ "`grep MISC /system/etc/tweaks.conf`" ]; then
  setprop dalvik.vm.startheapsize 8m
  setprop wifi.supplicant_scan_interval 90
fi

# We will delete these links including the symlink to CWM's busybox, so they won't interfere with the optionally installed busybox on the device
/sbin/busybox rm /sbin/[
/sbin/busybox rm /sbin/[[
/sbin/busybox rm /sbin/amend
/sbin/busybox rm /sbin/ash
/sbin/busybox rm /sbin/awk
/sbin/busybox rm /sbin/basename
/sbin/busybox rm /sbin/bbconfig
/sbin/busybox rm /sbin/bunzip2
/sbin/busybox rm /sbin/bzcat
/sbin/busybox rm /sbin/bzip2
/sbin/busybox rm /sbin/cal
/sbin/busybox rm /sbin/cat
/sbin/busybox rm /sbin/catv
/sbin/busybox rm /sbin/chgrp
/sbin/busybox rm /sbin/chmod
/sbin/busybox rm /sbin/chown
/sbin/busybox rm /sbin/chroot
/sbin/busybox rm /sbin/cksum
/sbin/busybox rm /sbin/clear
/sbin/busybox rm /sbin/cmp
/sbin/busybox rm /sbin/cp
/sbin/busybox rm /sbin/cpio
/sbin/busybox rm /sbin/cut
/sbin/busybox rm /sbin/date
/sbin/busybox rm /sbin/dc
/sbin/busybox rm /sbin/dd
/sbin/busybox rm /sbin/depmod
/sbin/busybox rm /sbin/devmem
/sbin/busybox rm /sbin/df
/sbin/busybox rm /sbin/diff
/sbin/busybox rm /sbin/dirname
/sbin/busybox rm /sbin/dmesg
/sbin/busybox rm /sbin/dos2unix
/sbin/busybox rm /sbin/du
/sbin/busybox rm /sbin/dump_image
/sbin/busybox rm /sbin/echo
/sbin/busybox rm /sbin/egrep
/sbin/busybox rm /sbin/env
/sbin/busybox rm /sbin/erase_image
/sbin/busybox rm /sbin/expr
/sbin/busybox rm /sbin/false
/sbin/busybox rm /sbin/fdisk
/sbin/busybox rm /sbin/fgrep
/sbin/busybox rm /sbin/find
/sbin/busybox rm /sbin/flash_image
/sbin/busybox rm /sbin/fold
/sbin/busybox rm /sbin/free
/sbin/busybox rm /sbin/freeramdisk
/sbin/busybox rm /sbin/fuser
/sbin/busybox rm /sbin/getopt
/sbin/busybox rm /sbin/grep
/sbin/busybox rm /sbin/gunzip
/sbin/busybox rm /sbin/gzip
/sbin/busybox rm /sbin/head
/sbin/busybox rm /sbin/hexdump
/sbin/busybox rm /sbin/id
/sbin/busybox rm /sbin/insmod
/sbin/busybox rm /sbin/install
/sbin/busybox rm /sbin/kill
/sbin/busybox rm /sbin/killall
/sbin/busybox rm /sbin/killall5
/sbin/busybox rm /sbin/length
/sbin/busybox rm /sbin/less
/sbin/busybox rm /sbin/ln
/sbin/busybox rm /sbin/losetup
/sbin/busybox rm /sbin/ls
/sbin/busybox rm /sbin/lsmod
/sbin/busybox rm /sbin/lspci
/sbin/busybox rm /sbin/lsusb
/sbin/busybox rm /sbin/lzop
/sbin/busybox rm /sbin/lzopcat
/sbin/busybox rm /sbin/md5sum
/sbin/busybox rm /sbin/mkdir
/sbin/busybox rm /sbin/mkfifo
/sbin/busybox rm /sbin/mknod
/sbin/busybox rm /sbin/mkswap
/sbin/busybox rm /sbin/mktemp
/sbin/busybox rm /sbin/mkyaffs2image
/sbin/busybox rm /sbin/modprobe
/sbin/busybox rm /sbin/more
/sbin/busybox rm /sbin/mount
/sbin/busybox rm /sbin/mountpoint
/sbin/busybox rm /sbin/mv
/sbin/busybox rm /sbin/nandroid
/sbin/busybox rm /sbin/nice
/sbin/busybox rm /sbin/nohup
/sbin/busybox rm /sbin/od
/sbin/busybox rm /sbin/patch
/sbin/busybox rm /sbin/pgrep
/sbin/busybox rm /sbin/pidof
/sbin/busybox rm /sbin/pkill
/sbin/busybox rm /sbin/printenv
/sbin/busybox rm /sbin/printf
/sbin/busybox rm /sbin/ps
/sbin/busybox rm /sbin/pwd
/sbin/busybox rm /sbin/rdev
/sbin/busybox rm /sbin/readlink
/sbin/busybox rm /sbin/realpath
/sbin/busybox rm /sbin/reboot
/sbin/busybox rm /sbin/renice
/sbin/busybox rm /sbin/reset
/sbin/busybox rm /sbin/rm
/sbin/busybox rm /sbin/rmdir
/sbin/busybox rm /sbin/rmmod
/sbin/busybox rm /sbin/run-parts
/sbin/busybox rm /sbin/sed
/sbin/busybox rm /sbin/seq
/sbin/busybox rm /sbin/setsid
/sbin/busybox rm /sbin/sh
/sbin/busybox rm /sbin/sha1sum
/sbin/busybox rm /sbin/sha256sum
/sbin/busybox rm /sbin/sha512sum
/sbin/busybox rm /sbin/sleep
/sbin/busybox rm /sbin/sort
/sbin/busybox rm /sbin/split
/sbin/busybox rm /sbin/stat
/sbin/busybox rm /sbin/strings
/sbin/busybox rm /sbin/stty
/sbin/busybox rm /sbin/swapoff
/sbin/busybox rm /sbin/swapon
/sbin/busybox rm /sbin/sync
/sbin/busybox rm /sbin/sysctl
/sbin/busybox rm /sbin/tac
/sbin/busybox rm /sbin/tail
/sbin/busybox rm /sbin/tar
/sbin/busybox rm /sbin/tee
/sbin/busybox rm /sbin/test
/sbin/busybox rm /sbin/time
/sbin/busybox rm /sbin/top
/sbin/busybox rm /sbin/touch
/sbin/busybox rm /sbin/tr
/sbin/busybox rm /sbin/true
/sbin/busybox rm /sbin/truncate
/sbin/busybox rm /sbin/tty
/sbin/busybox rm /sbin/umount
/sbin/busybox rm /sbin/uname
/sbin/busybox rm /sbin/uniq
/sbin/busybox rm /sbin/unix2dos
/sbin/busybox rm /sbin/unlzop
/sbin/busybox rm /sbin/unyaffs
/sbin/busybox rm /sbin/unzip
/sbin/busybox rm /sbin/uptime
/sbin/busybox rm /sbin/usleep
/sbin/busybox rm /sbin/uudecode
/sbin/busybox rm /sbin/uuencode
/sbin/busybox rm /sbin/watch
/sbin/busybox rm /sbin/wc
/sbin/busybox rm /sbin/which
/sbin/busybox rm /sbin/whoami
/sbin/busybox rm /sbin/xargs
/sbin/busybox rm /sbin/yes
/sbin/busybox rm /sbin/zcat

# Put the rfs creation tools back, they are needed if you want to install apps to sdcard
/sbin/busybox cp /sbin/fat.format /system/bin/fat.format
# /sbin/busybox mv /system/bin/newfs_msdos.bak /system/bin/newfs_msdos

# Remove the included shared modules, they can be also found on /system anyway
# /sbin/busybox rm /lib/*.so

# we'll need mount to remount the rootfs ro
/sbin/busybox ln -s /sbin/recovery /res/mount

# self destruct :)
/sbin/busybox rm /sbin/busybox

# init.d support
cd /sbin/init.d
echo $(date) USER EARLY INIT START
if cd /system/etc/init.d >/dev/null 2>&1 ; then
    for file in E* ; do
        if ! cat "$file" >/dev/null 2>&1 ; then continue ; fi
        echo "START '$file'"
        /system/bin/sh "$file"
        echo "EXIT '$file' ($?)"
    done
fi
echo $(date) USER EARLY INIT DONE
echo $(date) USER INIT START
if cd /system/etc/init.d >/dev/null 2>&1 ; then
    for file in S* ; do
        if ! ls "$file" >/dev/null 2>&1 ; then continue ; fi
        echo "START '$file'"
        /system/bin/sh "$file"
        echo "EXIT '$file' ($?)"
    done
fi
echo $(date) USER INIT DONE

# rootfs and system should be closed for now
/res/mount -o remount,ro /
/res/mount -o remount,ro /system

# continue with playing the logo
exec /system/bin/playlogos1

