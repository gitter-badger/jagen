#!/bin/sh

p_source_dir="$jagen_src_dir/sigma-ezboot"
p_source_branch="sdk4"

use_env tools
use_toolchain target

export RMCFLAGS="$RMCFLAGS \
-DRMCHIP_ID=RMCHIP_ID_SMP8652 \
-DRMCHIP_REVISION=3 \
-DWITH_PROD=1"

jagen_pkg_build() {
    add_PATH "$SMP86XX_TOOLCHAIN_PATH/bin"
    add_PATH "$sdk_rootfs_prefix/bin"

    pkg_run cd "xos/xboot2/xmasboot/nand_st2"
    pkg_run ./build_phyblock0.bash
}

jagen_pkg_install() {
    pkg_run mkdir -p "$jagen_target_dir"
    pkg_run cd "xos/xboot2/xmasboot/nand_st2"
    pkg_run cp -f phyblock0-0x20000padded.AST50 "$jagen_target_dir"
    pkg_run cp -f phyblock0-0x20000padded.AST100 "$jagen_target_dir"
}
