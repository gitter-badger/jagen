#!/bin/sh

jagen_sdk='sigma'

jagen_target_system="mipsel-linux-gnu"
jagen_target_prefix="/firmware"

jagen_target_arch="mips"
jagen_target_cpu="24kf"
jagen_target_board="${jagen_target_board:-ast100}"

jagen_target_toolchain_dir="${jagen_target_dir}"

sdk_ezboot_dir="$jagen_src_dir/sigma-ezboot"
sdk_kernel_dir="$jagen_src_dir/sigma-kernel"
sdk_mrua_dir="$jagen_src_dir/sigma-mrua"

sdk_rootfs_dir="$jagen_src_dir/sigma-rootfs"
sdk_rootfs_root="$sdk_rootfs_dir/build_mipsel/root"
sdk_rootfs_prefix="$sdk_rootfs_dir/cross_rootfs"

export SMP86XX_ROOTFS_PATH="$sdk_rootfs_dir"
export INSTALL_MOD_PATH="$sdk_rootfs_root"

export SMP86XX_TOOLCHAIN_PATH="$jagen_toolchain_dir"
export TOOLCHAIN_RUNTIME_PATH="$jagen_toolchain_dir/mips-linux-gnu/libc/el"

# MRUA
export RMCFLAGS="-DEM86XX_CHIP=EM86XX_CHIPID_TANGO3 \
-DEM86XX_REVISION=3 \
-DEM86XX_MODE=EM86XX_MODEID_STANDALONE \
-DWITHOUT_NERO_SPU=1 \
-DWITHOUT_RMOUTPUT=1 \
-DWITH_REALVIDEO=1 \
-DWITH_XLOADED_UCODE=1 \
-DXBOOT2_SMP865X=1"

if in_flags "sigma_with_monitoring"; then
    RMCFLAGS="$RMCFLAGS -DWITH_PROC=1 -DWITH_MONITORING=1"
fi

export COMPILKIND="codesourcery glibc hardfloat"
if [ "$jagen_build_type" = "Debug" ]; then
    COMPILKIND="$COMPILKIND debug"
else
    COMPILKIND="$COMPILKIND release"
fi

kernel_release="2.6.32.15-21-sigma"
cpukeys="CPU_KEYS_SMP86xx_2010-02-12"

xsdk_dir="$jagen_build_dir/xsdk/$cpukeys"

# XSDK
export XSDK_ROOT="$xsdk_dir/signed_items"
export XSDK_DEFAULT_KEY_DOMAIN=8644_ES1_prod
export XSDK_DEFAULT_ZBOOT_CERTID=0000
export XSDK_DEFAULT_CPU_CERTID=0001

if [ -d "$xsdk_dir/xbin" ]; then
    add_PATH "$xsdk_dir/xbin"
fi

kernel_dir="$jagen_src_dir/sigma-kernel"
kernel_modules_dir="$sdk_rootfs_root/lib/modules/$kernel_release"
kernel_extra_modules_dir="$kernel_modules_dir/extra"

export LINUX_KERNEL="$jagen_src_dir/linux"
export UCLINUX_KERNEL="$LINUX_KERNEL"
